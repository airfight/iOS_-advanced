//
//  TimerVc.swift
//  SwiftThread
//
//  Created by ZGY on 2018/1/4.
//Copyright © 2018年 macpro. All rights reserved.
//
//  Author:        Airfight
//  My GitHub:     https://github.com/airfight
//  My Blog:       http://airfight.github.io/
//  My Jane book:  http://www.jianshu.com/users/17d6a01e3361
//  Current Time:  2018/1/4  下午1:04
//  GiantForJade:  Efforts to do my best
//  Real developers ship.

import UIKit

protocol Pizzeria {
    func makePizza(_ ingredients:[String])
    func makeMargherita()
}

extension Pizzeria {
    func makeMargherita() {
        return makePizza(["1"])
    }
}

struct Lomabards:Pizzeria {
    func makeMargherita() {
        return makePizza(["2"])
    }
    
    func makePizza(_ ingredients: [String]) {
        print(ingredients)
    }
}

class TimerVc: UIViewController {
    
    //MARK: - Attributes
    
    var timer:Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
//        timer = Timer(timeInterval: 1, target: self, selector: #selector(run), userInfo: nil, repeats: true)
//        RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
//        timer.fire()
        
    }
    
    @objc func run() {
        print("run")
    }
    
    deinit {
//        timer.invalidate()
//        timer = nil
        print("销毁了")
    }
    
    //MARK: - Override
    
    
    //MARK: - Initial Methods
    
    
    //MARK: - Delegate
    
    
    //MARK: - Target Methods
    
    
    //MARK: - Notification Methods
    
    
    //MARK: - KVO Methods
    
    
    //MARK: - UITableViewDelegate, UITableViewDataSource
    
    
    //MARK: - Privater Methods
    
    
    //MARK: - Setter Getter Methods
    
    
    //MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
