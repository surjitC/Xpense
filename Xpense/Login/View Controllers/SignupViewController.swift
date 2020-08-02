//
//  SignupViewController.swift
//  Xpense
//
//  Created by Surjit on 24/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    class func instantiateVC() -> SignupViewController {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else {
            return SignupViewController()
        }
        return vc
    }
    
    // MARK: - Properties
    @IBOutlet var firstnameTextField: UITextField!
    @IBOutlet var lastnameTextfield: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var signupButton: UIButton!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.delegate = self
        self.configureUI()
    }
    
    private func configureUI() {
        self.firstnameTextField.addDepth()
        self.lastnameTextfield.addDepth()
        self.emailTextField.addDepth()
        self.passwordTextfield.addDepth()
        self.signupButton.makecoloredButton()
        self.emailTextField.delegate = self
        self.passwordTextfield.delegate = self
        self.firstnameTextField.delegate = self
        self.lastnameTextfield.delegate = self
    }

    @IBAction func signupButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let firstname = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let lastname = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
                
            return
        }
        self.showSpinner(on: self.view)
        let user = User(firstname: firstname, lastname: lastname, email: email, password: password)
        self.viewModel?.createUser(using: user)
    }
    @IBAction func LoginTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension SignupViewController: LoginViewControllerProtocol {
    func completionHandler(_ success: Bool) {
        self.removeSpinner()
        print(success)
        if success {
            let vc = HomeViewController.instantiateVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
