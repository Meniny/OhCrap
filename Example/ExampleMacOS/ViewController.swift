//
//  ViewController.swift
//  ExampleMacOS
//
//  Created by Meniny on 2017-05-11.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import Cocoa
import OhCrap

class ViewController: NSViewController, OhCrapDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        OhCrap.isEnabled = true
        OhCrap.delegate = self
    }
    
    func ohCrapDidCatch(_ exception: NSException, forType type: OhCrap.CrashType) {
        let userInfo = (exception.userInfo ?? [:]) as NSDictionary
        try? "\(type)\n\(userInfo)".write(toFile: "/Users/Meniny/Desktop/\(Date())\(type).txt", atomically: true, encoding: .utf8)
    }
    
    private func crashSigbart() {
        let _ = (view as! NSButton).title
    }
    
    private func crashExecption() {
        self.deleteForward(nil)
    }
    
    
    override func mouseDown(with event: NSEvent) {
        let number = Int(arc4random_uniform(9999))
        if number % 2 != 0 {
            crashSigbart()
        } else {
            crashExecption()
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

