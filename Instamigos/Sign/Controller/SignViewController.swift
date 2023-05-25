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
    
    @IBOutlet weak var signUpBarView: UIView!
    @IBOutlet weak var signInBarView: UIView!
    
    var signUp = true
    
    weak var mainCoordinator: MainCoordinator?
    var signViewModel: SignViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        signInBarView.isHidden = true
        allTextFields.forEach { $0.delegate = self }
        signCardView.layer.cornerRadius = 10.0
        signCardView.applyShadow()
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        eraseAllFields()
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        hideBarViews()
        nameTextField.isHidden = true
        confirmPasswordTextField.isHidden = true
        welcomeDescription.text = "Have a account? Sign In"
        signConfirmButton.setTitle("Sign In", for: .normal)
        signInBarView.isHidden = false
        signUp = false
    }
    
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        hideBarViews()
        allTextFields.forEach { $0.isHidden = false }
        welcomeDescription.text = "New here? Sign Up"
        signConfirmButton.setTitle("Sign Up", for: .normal)
        signUpBarView.isHidden = false
        signUp = true
    }
    
    @IBAction func signConfirmButtonAction(_ sender: Any) {
        if signUp {
            createUser()
        } else {
            loginUser()
        }
    }
    
    func hideBarViews() {
        signUpBarView.isHidden = true
        signInBarView.isHidden = true
    }
    
    func createUser() {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        if let validateFields = signViewModel?.validateFields(name: name, email: email, password: password, confirmPassword: confirmPassword, completion: showAlertVoid(message:)) {
            if validateFields {
                signViewModel?.postUser(name: name, email: email, password: password) {
                    self.mainCoordinator?.showAlert(viewController: self, message: "User created successfully") { _ in
                        self.mainCoordinator?.callFeedViewController()
                        
                    }
                }
            }
        }
    }
    
    func loginUser() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        signViewModel?.loginUser(email: email, password: password) {
            self.mainCoordinator?.callFeedViewController()
        }
    }
    
    func showAlertVoid(message: String) {
        mainCoordinator?.showAlert(viewController: self, message: message, handler: nil)
    }
    
    func eraseAllFields() {
        allTextFields.forEach { $0.text = "" }
    }
}

extension SignViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

