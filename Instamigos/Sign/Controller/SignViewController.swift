//
//  ViewController.swift
//  Instamigos
//
//  Created by Cáren Sousa on 18/05/23.
//

import UIKit

class SignViewController: UIViewController {
    
    @IBOutlet weak var welcomeDescription: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signConfirmButton: UIButton!
    @IBOutlet var allTextFields: [UITextField]!
    @IBOutlet weak var signCardView: UIView!
    let signViewModel = SignViewModel()
    var signUp = true
    weak var mainCoordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allTextFields.forEach { $0.delegate = self }
        signCardView.layer.cornerRadius = 10.0
        signCardView.applyShadow()
        emailTextField.text = "elaniacs@gmail.com"
        passwordTextField.text = "123456"
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        nameTextField.isHidden = true
        confirmPasswordTextField.isHidden = true
        welcomeDescription.text = "Have a account? Sign In"
        signConfirmButton.setTitle("Sign In", for: .normal)
        signUp = false
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        allTextFields.forEach { $0.isHidden = false }
        welcomeDescription.text = "New here? Sign Up"
        signConfirmButton.setTitle("Sign Up", for: .normal)
        signUp = true
    }
    
    @IBAction func signConfirmButtonAction(_ sender: Any) {
        if signUp {
            createUser()
        } else {
            loginUser()
        }
    }
    
    func createUser() {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text
        
        signViewModel.postUser(name: name, email: email, password: password)
    }
    
    func loginUser() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        signViewModel.loginUser(email: email, password: password) {
            self.mainCoordinator?.callFeedViewController()
        }
    }
}

extension SignViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// TODO: MOVER PARA UM ARQUIVO PRÓPRIO
extension UIView {
    func applyShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4
        layer.shouldRasterize = true
    }
}

