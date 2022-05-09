//
//  ProfileVC.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 05/05/22.
//

import UIKit
import FirebaseFirestore

class UsersVC: UIViewController {
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var userTableView: UITableView!
    
    var firestore: Firestore?
    var users: [Dictionary<String, Any>] = []
    
    private func configTableViewCell(){
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        self.userTableView.separatorStyle = .none
        self.userTableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViewCell()
        self.firestore = Firestore.firestore()
    }
    

}

extension UsersVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell
        
        cell?.nameLabel.text = "name"
        cell?.emailLabel.text = "email"
//        cell?.pictureImageView.image =
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        105
    }
    
    
}
