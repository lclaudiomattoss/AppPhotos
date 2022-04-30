//
//  ViewController.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 30/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func tappedEnterButton(_ sender: Any) {
    }
    
    @IBAction func tappedRegisterButtonn(_ sender: Any) {
        let register:RegisterVC? = UIStoryboard(name: "RegisterVC", bundle: nil).instantiateViewController(withIdentifier: "RegisterVC") as? RegisterVC
        self.present(register ?? UIViewController() , animated: true, completion: nil)
    }


}

