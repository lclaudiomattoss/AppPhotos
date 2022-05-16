//
//  GaleryVC.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 09/05/22.
//

import UIKit
import FirebaseFirestore
import FirebaseStorageUI

class GaleryVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var user: Dictionary<String, Any>?
    var firestore: Firestore?
    var posts: [Dictionary<String, Any>] = []
    var idUserSelected: String?
    
    private func configCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(GaleryCollectionViewCell.nib(), forCellWithReuseIdentifier: GaleryCollectionViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configCollectionView()
        self.firestore = Firestore.firestore()
        if let id = user?["id"] as? String{
            self.idUserSelected = id
        }
        if let name = user?["name"] as? String{
            self.navigationItem.title = name
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.chooseImages()
    }
    
    func chooseImages(){
        self.posts.removeAll()
        self.collectionView.reloadData()
        
        firestore?.collection("posts")
            .document(idUserSelected ?? "")
            .collection("post_users")
            .getDocuments{ snapshotResult, error in
                
                if let snapshot = snapshotResult{
                    for document in snapshot.documents {
                        let data = document.data()
                        self.posts.append(data)
                    }
                    self.collectionView.reloadData()
                }
                
            }
        
    }
}

extension GaleryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GaleryCollectionViewCell.identifier, for: indexPath) as? GaleryCollectionViewCell
        let post = self.posts[indexPath.row]
        if let url = post["url"] as? String{
            cell?.pictureImageView.sd_setImage(with: URL(string: url), completed: nil)
        }
//        cell?.pictureImageView.image = UIImage(named: "picture")
        return cell ?? UICollectionViewCell()
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/3)-3, height: (view.frame.size.width/3)-3)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
