//
//  OhCrapValues.swift
//  OhCrap
//
//  Created by Meniny on 2017-05-11.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import Foundation
import Darwin

extension OhCrap {
    
    public static var UncaughtExceptionCount: Int32 = 0
    public static let UncaughtExceptionMaximum: Int32 = 10
    
    public static let SkipAddressCount: Int = 4
    public static let ReportAddressCount: Int = 5
    
    public enum Keys: String {
        case signalExceptionName =      "OhCrapSignalExceptionName"
        case signalKey =                "OhCrapSignalKey"
        case addressesKey =             "OhCrapAddressesKey"
        
        case assertLanguageKey =        "OhCrapAssertLanguageKey"
        
        case assertOCMethodKey =        "OhCrapAssertOCMethodKey"
        case assertOCFileKey =          "OhCrapAssertOCFileKey"
        case assertOCObjectKey =        "OhCrapAssertOCObjectKey"
        case assertOCLineKey =          "OhCrapAssertOCLineKey"
        
        case assertCFunctionKey =       "OhCrapAssertCFunctionKey"
        case assertCFileKey =           "OhCrapAssertCFileKey"
        case assertCLineKey =           "OhCrapAssertCLineKey"
    }
    
    public enum Signal: String {
        case ILL = "SIGILL"
        case ABRT = "SIGABRT"
        case FPE = "SIGFPE"
        case BUS = "SIGBUS"
        case SEGV = "SIGSEGV"
        case SYS = "SIGSYS"
        case PIPE = "SIGPIPE"
        case TRAP = "SIGTRAP"
        case UNKNOWN = "SIGUNKNOWN"
        
        init(_ signal: Int32) {
            switch signal {
            case SIGILL:
                self = .ILL
            case SIGABRT:
                self = .ABRT
            case SIGFPE:
                self = .FPE
            case SIGBUS:
                self = .BUS
            case SIGSEGV:
                self = .SEGV
            case SIGSYS:
                self = .SYS
            case SIGPIPE:
                self = .PIPE
            case SIGTRAP:
                self = .TRAP
            default:
                self = .UNKNOWN
            }
        }
    }

    public enum Language: String {
        case swift = "Swift"
        case c = "C"
        case cpp = "C++"
        case objc = "Objective-C"
        case objcpp = "Objective-C++"
    }
}
