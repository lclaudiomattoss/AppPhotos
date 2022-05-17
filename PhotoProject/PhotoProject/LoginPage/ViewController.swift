//
//  ViewController.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 30/04/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var auth: Auth?
    
    func loginControl(){
        auth?.addStateDidChangeListener({ autentication, user in
            if user != nil {
                self.performSegue(withIdentifier: "TabBarController", sender: nil)
            }else{
                print("O usuário não está logado")
            }
        })
    }
    
    func configInitials(){
        self.enterButton.isEnabled = false
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.errorLabel.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configInitials()
        self.loginControl()
        self.hideKeyboardWhenTappedAround()
        auth = Auth.auth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        do {
            try auth?.signOut()
        } catch {
            print("Erro ao deslogar usuário!")
        }
        
    }
    
    
    @IBAction func tappedEnterButton(_ sender: Any) {
        
        if let email = emailTextField.text{
            if let password = passwordTextField.text{
                
                auth?.signIn(withEmail: email, password: password) { (user,error) in
                    if error == nil{
                        print("Sucesso ao logar usuário")
                        self.performSegue(withIdentifier: "TabBarController", sender: nil)
                        self.errorLabel.text = ""
                    }else{
                        print("Erro ao logar usuário")
                        self.errorLabel.text = "O email e a senha não correspondem"
                        self.emailTextField.layer.borderColor = UIColor.red.cgColor
                        self.emailTextField.layer.borderWidth = 2.0
                        self.passwordTextField.layer.borderColor = UIColor.red.cgColor
                        self.passwordTextField.layer.borderWidth = 2.0
                    }
                }
            }else{
                self.errorLabel.text = "O email e a senha não correspondem"
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                self.emailTextField.layer.borderWidth = 2.0
                self.passwordTextField.layer.borderColor = UIColor.red.cgColor
                self.passwordTextField.layer.borderWidth = 2.0
            }
        }else{
            self.errorLabel.text = "O email e a senha não correspondem"
            self.emailTextField.layer.borderColor = UIColor.red.cgColor
            self.emailTextField.layer.borderWidth = 2.0
            self.passwordTextField.layer.borderColor = UIColor.red.cgColor
            self.passwordTextField.layer.borderWidth = 2.0
        }
    }
        
    
    @IBAction func tappedRegisterButtonn(_ sender: Any) {
        performSegue(withIdentifier: "RegisterVC", sender: self)
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        
        if textField == self.emailTextField{
            self.passwordTextField.becomeFirstResponder()
        }else{
                    textField.resignFirstResponder()
                }
        
        if textField == self.emailTextField{
            if self.emailTextField.text == ""{
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                self.emailTextField.layer.borderWidth = 2.0
            }else{
                self.emailTextField.layer.borderWidth = 0.0
            }
        }
        
        
        if textField == self.passwordTextField{
            if self.passwordTextField.text == ""{
                self.passwordTextField.layer.borderColor = UIColor.red.cgColor
                self.passwordTextField.layer.borderWidth = 2.0
            }else{
                self.emailTextField.layer.borderWidth = 0.0
                self.passwordTextField.layer.borderWidth = 0.0
            }
        }
        
        if self.emailTextField.text != "" && self.passwordTextField.text != ""{
            self.enterButton.isEnabled = true
        }else{
            self.enterButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(#function)
        return true
    }
}

extension UIViewController {
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    public func dismissAllKeyboard() {
        DispatchQueue.main.async {
            for textField in self.view.subviews where textField is UITextField {
                textField.resignFirstResponder()
            }
        }
    }

}
