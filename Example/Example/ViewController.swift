//
//  ViewController.swift
//  Example
//
//  Created by Meniny on 2017-05-11.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
import OhCrap

class ViewController: UIViewController, OhCrapDelegate {

    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.purple
        self.label.frame = self.view.bounds
        self.view.addSubview(self.label)
        self.label.textColor = UIColor.white
        self.label.textAlignment = .center
        self.label.text = "Press to test"
        OhCrap.isEnabled = true
        OhCrap.delegate = self
    }
    
    func ohCrapDidCatch(_ exception: NSException, forType type: OhCrap.CrashType) {
        let userInfo = (exception.userInfo ?? [:]) as NSDictionary
        try? "\(type)\n\(userInfo)".write(toFile: "~/Desktop/\(Date())\(type).txt", atomically: true, encoding: .utf8)
    }
    
    private func crashSigbart() {
        let _ = (view as! UIButton).showsTouchWhenHighlighted
    }
    
    private func crashExecption() {
        self.delete(nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let number = Int(arc4random_uniform(9999))
        if number % 2 != 0 {
            crashSigbart()
        } else {
            crashExecption()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

