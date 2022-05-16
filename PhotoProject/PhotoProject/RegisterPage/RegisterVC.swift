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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        
        if let name = nameTextField.text{
            if let email = emailTextField.text{
                if let password = passwordTextField.text{
                    
                    auth?.createUser(withEmail: email, password: password) { (data, error) in
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
                            
                            
                        }else{
                            print("Erro ao cadastrar usuário")
                        }
                    }
                    
                }else{
                    print("Preencha a sua senha")
                }
            }else{
                print("Preencha o seu email")
            }
        }else{
            print("Preencha o seu nome")
        }
        
    }
            
                    
                    
    
}
