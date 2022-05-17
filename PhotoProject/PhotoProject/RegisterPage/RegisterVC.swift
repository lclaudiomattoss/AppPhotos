//
//  RegisterViewController.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 30/04/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterVC: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var auth: Auth?
    var firestore: Firestore?
    private var alert:AlertController?
    
    func configInitials(){
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.registerButton.isEnabled = false
        self.errorLabel.text = ""
        self.hideKeyboardWhenTappedAround()
        self.alert = AlertController(controller: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.configInitials()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        
        if let name = nameTextField.text{
            if let email = emailTextField.text{
                if let password = passwordTextField.text{
                    self.alert?.showAlert(title: "Confirma os dados?", message: "", titleButton: "Confirmar", completion: { value in
                        switch value {
                        case .aceitar:
                            self.auth?.createUser(withEmail: email, password: password) { (data, error) in
                                if error == nil{
                                    if let idUser = data?.user.uid{
                                        self.firestore?.collection("users")
                                            .document( idUser )
                                            .setData([
                                                "name": name,
                                                "email": email,
                                                "id": idUser
                                            ])
                                    }
                                }
                            }
                            self.dismiss(animated: true)
                        case .cancel:
                            print("cancelado")
                        }
                    })
                    self.errorLabel.text = ""
                }
            }else{
                self.errorLabel.text = "Erro ao cadastrar usuário"
            }
        }else{
            self.errorLabel.text = "Preencha os dados corretamente"
        }
    }
}

extension RegisterVC:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.blue.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        
        if textField == self.nameTextField{
            self.emailTextField.becomeFirstResponder()
        }else{
            if textField == self.emailTextField{
                self.passwordTextField.becomeFirstResponder()
            }else{
                    textField.resignFirstResponder()
                }
            }
        
        if textField == self.nameTextField{
            if self.nameTextField.text == ""{
                self.nameTextField.layer.borderColor = UIColor.red.cgColor
                self.nameTextField.layer.borderWidth = 2.0
            }else{
                self.nameTextField.layer.borderWidth = 0.0
            }
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
                self.passwordTextField.layer.borderWidth = 0.0
            }
        }
        
        if self.nameTextField.text != "" && self.emailTextField.text != "" && self.passwordTextField.text != ""{
                self.registerButton.isEnabled = true
                }else{
                    self.registerButton.isEnabled = false
                }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(#function)
        return true
    }
    
}

