//
//  ConfigVC.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 05/05/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorageUI

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postsLabel: UILabel!
    
    var firestore: Firestore?
    var auth: Auth?
    var users: [Dictionary<String, Any>] = []
    var posts: [Dictionary<String, Any>] = []
    var idUserLog: String?
    
    func configItems(){
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.myColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Meu perfil"
    }

    func getProfileData(){
        
        let user = self.firestore?.collection("users").document(self.idUserLog ?? "")
        user?.getDocument(completion: { documentSnapshot, error in
            if error == nil{

                let data1 = documentSnapshot?.data()
                let data2 = data1?["name"]
                self.nameLabel.text = data2 as? String
                if let url = data1?["url"] as? String{
                    self.profileImageView.sd_setImage(with: URL(string: url), completed: nil)
                }
                }
            }
        )
    }
    
    func maskCircle(){
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configItems()
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        self.maskCircle()
        if let idUser = auth?.currentUser?.uid{
            self.idUserLog = idUser
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getProfileData()
    }
    
}
