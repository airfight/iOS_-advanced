//
//  ViewController.swift
//  SwiftThread
//
//  Created by macpro on 2017/12/26.
//  Copyright © 2017年 macpro. All rights reserved.
//

import UIKit

struct Temperature {
    var value: Float = 37.0
}

class Person {
    var temp: Temperature?
    
    func sick() {
        temp?.value = 41.0
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let A = Person()
        let B = Person()
        let temp = Temperature()
        
        A.temp = temp
        B.temp = temp
        
        A.sick()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
