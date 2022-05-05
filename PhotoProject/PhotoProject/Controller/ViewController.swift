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
    
    var auth: Auth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        auth = Auth.auth()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @IBAction func tappedEnterButton(_ sender: Any) {
        
        if let email = emailTextField.text{
            if let password = passwordTextField.text{
                
                auth.signIn(withEmail: email, password: password) { (user,error) in
                    if error == nil{
                        print("Sucesso ao logar usuário")
                    }else{
                        print("Erro ao logar usuário")
                    }
                }
                
                
                
            }else{
                print("Preencha a sua senha")
            }
        
        }else{
            print("Preencha o seu email")
        }
    }
        
    
    @IBAction func tappedRegisterButtonn(_ sender: Any) {
        performSegue(withIdentifier: "RegisterVC", sender: self)
    }


}

