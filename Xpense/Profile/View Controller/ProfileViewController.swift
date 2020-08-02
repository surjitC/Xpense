//
//  ProfileViewController.swift
//  Xpense
//
//  Created by Surjit on 29/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    class func instantiateVC() -> ProfileViewController {
        guard let vc = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController else {
            return ProfileViewController()
        }
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    @IBAction func logoutTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popViewController(animated: true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
