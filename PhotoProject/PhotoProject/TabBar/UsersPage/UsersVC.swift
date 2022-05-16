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
    
    func configItems(){
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.myColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "Usuários"
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViewCell()
        self.firestore = Firestore.firestore()
        self.userSearchBar.delegate = self
        self.configItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.chooseImages()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GaleryVC"{
            let viewDestine = segue.destination as? GaleryVC
            
            viewDestine?.user = sender as? Dictionary
        }
    }
    
    func searchUsers(text: String ){
        let listFilter: [Dictionary<String, Any>] = self.users
        self.users.removeAll()
        
        for item in listFilter{
            if let name = item["name"] as? String{
                if name.lowercased().contains(text.lowercased()){
                    self.users.append(item)
                }
            }
        }
        self.userTableView.reloadData()
    }
    
    func chooseImages(){
        self.users.removeAll()
        self.userTableView.reloadData()
        
        firestore?.collection("users").getDocuments{ snapshotResult, error in
            if let snapshot = snapshotResult{
                for document in snapshot.documents {
                    let data = document.data()
                    self.users.append(data)
                }
                self.userTableView.reloadData()
            }
        }
    }
    

}

extension UsersVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell
        
        let user = self.users[indexPath.row]
        let name  = user["name"] as? String
        let email = user["email"] as? String
        
        cell?.nameLabel.text = name
        cell?.emailLabel.text =  email
//        cell?.pictureImageView.image =
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.userTableView.deselectRow(at: indexPath, animated: true)
        
        let user = self.users[indexPath.row]
        
        self.performSegue(withIdentifier: "GaleryVC", sender: user)
    }
    
}

extension UsersVC: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let textSearch = userSearchBar.text{
            if textSearch != ""{
                searchUsers(text: textSearch )
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            chooseImages()
        }
    }
    
}
