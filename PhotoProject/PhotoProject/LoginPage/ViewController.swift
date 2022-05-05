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
    
    var auth: Auth?
    
    func LoginControl(){
        auth?.addStateDidChangeListener({ autentication, user in
            if user != nil {
                self.performSegue(withIdentifier: "TabBarController", sender: nil)
            }else{
                print("O usuário não está logado")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.LoginControl()
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

