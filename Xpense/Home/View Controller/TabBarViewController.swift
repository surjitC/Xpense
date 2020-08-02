//
//  TabBarViewController.swift
//  Xpense
//
//  Created by Surjit on 26/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    class func instantiateVC() -> TabBarViewController {
        guard let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {
            return TabBarViewController()
        }
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let vc = HomeViewController.instantiateVC()
//        self.tabBarController?.setViewControllers([vc], animated: true)
        // Do any additional setup after loading the view.
    }

}
