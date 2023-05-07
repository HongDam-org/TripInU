//
//  ViewController.swift
//  TripInU
//
//  Created by Sean Hong on 2023/05/03.
//

import UIKit

class ViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        let vc2 = UIViewController()
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        let vc3 = UIViewController()
        vc3.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        let vc4 = UIViewController()
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 3)
        let myPageviewController = MyPageViewController()
        myPageviewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 4)
        
        let controllers = [homeViewController, vc2, vc3, vc4, myPageviewController]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
    }
}




