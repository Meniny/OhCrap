//
//  File.swift
//  OhCrap
//
//  Created by Meniny on 2017-05-11.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import Foundation
import Darwin

public protocol OhCrapDelegate: class {
    func ohCrapDidCatch(_ exception: NSException, forType type: OhCrap.CrashType)
}

public final class OhCrap {
    
    public enum CrashType: String {
        case signal = "Signal"
        case exception = "Exception"
    }
    
    weak public static var delegate: OhCrapDelegate?
    
    public static var isEnabled: Bool = true {
        didSet {
            if isEnabled {
                OhCrap.register()
            }
            else {
                OhCrap.unregister()
            }
        }
    }
    
    private static func register() {
        NSSetUncaughtExceptionHandler(OhCrap.handleException)
        signal(SIGILL, OhCrap.handleSignal)
        signal(SIGABRT, OhCrap.handleSignal)
        signal(SIGFPE, OhCrap.handleSignal)
        signal(SIGBUS, OhCrap.handleSignal)
        signal(SIGSEGV, OhCrap.handleSignal)
        signal(SIGSYS, OhCrap.handleSignal)
        signal(SIGPIPE, OhCrap.handleSignal)
        signal(SIGTRAP, OhCrap.handleSignal)
    }
    
    private static func unregister() {
        NSSetUncaughtExceptionHandler(nil)
        signal(SIGILL, SIG_DFL)
        signal(SIGABRT, SIG_DFL)
        signal(SIGFPE, SIG_DFL)
        signal(SIGBUS, SIG_DFL)
        signal(SIGSEGV, SIG_DFL)
        signal(SIGSYS, SIG_DFL)
        signal(SIGPIPE, SIG_DFL)
        signal(SIGTRAP, SIG_DFL)
    }
    
    public static func killall() {
        self.unregister()
        kill(getpid(), SIGKILL)
    }
    
    private static let handleException: @convention(c) (NSException) -> Void = { (exception) -> Void in
//        let count = OSAtomicIncrement32(&OhCrap.UncaughtExceptionCount)
//        if count > OhCrap.UncaughtExceptionMaximum {
//            return
//        }
        let stack = Thread.callStackSymbols
        //        if stack.count > 1 {
        //            stack.removeFirst(2)
        //        }
        let callStack = stack.joined(separator: "\r")
        if var userInfo = exception.userInfo {
            for (k, v) in OhCrap.envInfo() {
                userInfo[k] = v
            }
            userInfo[OhCrap.Keys.addressesKey] = callStack
            OhCrap.delegate?.ohCrapDidCatch(NSException(name: exception.name, reason: exception.reason, userInfo: userInfo), forType: .exception)
        } else {
            var userInfo = OhCrap.envInfo()
            userInfo[OhCrap.Keys.addressesKey] = callStack
            OhCrap.delegate?.ohCrapDidCatch(NSException(name: exception.name, reason: exception.reason, userInfo: userInfo), forType: .exception)
        }
    }
    
    private static let handleSignal: @convention(c) (Int32) -> Void = { (signal) -> Void in
//        let count = OSAtomicIncrement32(&OhCrap.UncaughtExceptionCount)
//        if count > OhCrap.UncaughtExceptionMaximum {
//            return
//        }
        let es = OhCrap.Signal(signal)
        
        let stack = Thread.callStackSymbols
//        if stack.count > 1 {
//            stack.removeFirst(2)
//        }
        let callStack = stack.joined(separator: "\r")
        let reason = "Signal \(es.rawValue)(\(signal)) was raised."
        
        var userInfo = OhCrap.envInfo()
        userInfo[OhCrap.Keys.signalKey] = es.rawValue
        userInfo[OhCrap.Keys.addressesKey] = callStack
        let name = NSExceptionName(rawValue: OhCrap.Keys.signalExceptionName.rawValue)
        let exception = NSException(name: name, reason: reason, userInfo: userInfo)
//        exception.callStackSymbols = stack
        OhCrap.delegate?.ohCrapDidCatch(exception, forType: .signal)
    }
    
    private static func envInfo() -> [OhCrap.Keys: String] {
        let displayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") ?? ""
        let shortVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? ""
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? ""
        let info = [
            OhCrap.Keys.appNameKey: "\(displayName)",
            OhCrap.Keys.appVersionKey: "\(shortVersion)(\(version))",
            OhCrap.Keys.osVersionKey: ProcessInfo.processInfo.operatingSystemVersionString,
            ]
        return info
    }
    
    /*
    public static func trackAssertion(onThread thread: Thread = Thread.main) {
        thread.threadDictionary[NSAssertionHandlerKey] = self
    }
     
    public func handleFailureInMethod(_ aSelector: Selector, object: AnyObject, file: String, lineNumber: Int, description format: String...) {
     
    }
    
    public func handleFailureInFunction(_ functionName: String, file: String, lineNumber: Int, description format: String...) {
     
    }
    */
}


