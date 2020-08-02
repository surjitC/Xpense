//
//  SigninViewController.swift
//  Xpense
//
//  Created by Surjit on 23/07/20.
//  Copyright © 2020 Surjit Chowdhary. All rights reserved.
//

import UIKit
protocol LoginViewControllerProtocol: AnyObject {
    func completionHandler(_ success: Bool) -> Void
}
class SigninViewController: UIViewController {

    class func instantiateVC() -> SigninViewController {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SigninViewController") as? SigninViewController else {
            return SigninViewController()
        }
        return vc
    }
    
    // MARK: - Properties
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var googleSignInButton: UIButton!
    @IBOutlet var facebookSignInButton: UIButton!
    @IBOutlet var twitterSignInButton: UIButton!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.delegate = self
        emailTextField.delegate = self
        passwordTextfield.delegate = self
        self.configureUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.trySilentSignIn()
    }
    // MARK: - Configure UI
    private func configureUI() {
        self.emailTextField.addDepth()
        self.passwordTextfield.addDepth()
        self.loginButton.makecoloredButton()
        self.googleSignInButton.makeCircularButton()
        self.facebookSignInButton.makeCircularButton()
        self.twitterSignInButton.makeCircularButton()
    }

    private func trySilentSignIn() {
        guard let email = UserManager.shared.userName?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = UserManager.shared.userPassword?.trimmingCharacters(in: .whitespacesAndNewlines) else {

            return
        }
        self.showSpinner(on: self.view)
        viewModel.authenticatedUser(with: email, and: password)
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {

            return
        }
        UserManager.shared.userName = email
        UserManager.shared.userPassword = password
        self.showSpinner(on: self.view)
        viewModel.authenticatedUser(with: email, and: password)
    }
    @IBAction func SignupTapped(_ sender: Any) {
        let vc = SignupViewController.instantiateVC()
        vc.viewModel = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension SigninViewController: LoginViewControllerProtocol {
    
    func completionHandler(_ success: Bool) {
        self.removeSpinner()
        print(success)
        if success {
            let vc = TabBarViewController.instantiateVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
 
}

extension SigninViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

