//
//  HomeVC.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 05/05/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorageUI

class HomeVC: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var firestore: Firestore?
    var auth: Auth?
    var posts: [Dictionary<String, Any>] = []
    var idUserLog: String?
    
    private func configTableViewCell(){
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.separatorStyle = .none
        self.homeTableView.register(HomeTableViewCell.nib(), forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
    
    @objc private func tappedCamera(){
        performSegue(withIdentifier: "ChoosePictureVC", sender: nil)
    }
    
    
    func configItems(){
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.myColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.myColor
        self.navigationItem.title = "Minhas Imagens"
        self.navigationController?.navigationBar.tintColor = UIColor.myColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "camera.fill"),
            style: .done,
            target: self,
            action: #selector(tappedCamera)
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViewCell()
        self.firestore = Firestore.firestore()
        self.auth = Auth.auth()
        self.configItems()
        
        if let idUser = auth?.currentUser?.uid{
            self.idUserLog = idUser
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.chooseImages()
    }
    
    func chooseImages(){
        self.posts.removeAll()
        self.homeTableView.reloadData()
        
        firestore?.collection("posts")
            .document(idUserLog ?? "")
            .collection("post_users")
            .getDocuments{ snapshotResult, error in
                
                if let snapshot = snapshotResult{
                    for document in snapshot.documents {
                        let data = document.data()
                        self.posts.append(data)
                    }
                    self.homeTableView.reloadData()
                }
                
            }
        
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell
        
        let post = self.posts[indexPath.row]
        let description = post["description"] as? String
        if let url = post["url"] as? String{
            cell?.pictureImageView.sd_setImage(with: URL(string: url), completed: nil)
        }
        
        cell?.descriptionLabel.text = description
 
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
    
}
