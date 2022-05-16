//
//  choosePictureVC.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 08/05/22.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

class ChoosePictureVC: UIViewController {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var storage: Storage?
    var auth: Auth?
    var firestore: Firestore?
    
    func configOutlets(){
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.configOutlets()
        self.storage = Storage.storage()
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }
    
    @IBAction func tappedChooseButton(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func tappedSaveButton(_ sender: UIButton) {
        
        let images = storage?.reference()
            .child("images")
        let selectedImage = self.pictureImageView.image
        
        if let imageUpLoad = selectedImage?.jpegData(compressionQuality: 0.3){
            let identificator = UUID().uuidString
            let postImageRef = images?
                .child("post")
                .child("\(identificator).jpg")
            
            postImageRef?.putData(imageUpLoad, metadata: nil) { metaData, error in
                if error == nil{
                    
                    postImageRef?.downloadURL(completion: { url, error in
                        if let urlImage = url?.absoluteString {
                            if let description = self.descriptionTextField.text{
                                if let userLog = self.auth?.currentUser{
                                    
                                    let idUser = userLog.uid
                                    
                                    self.firestore?.collection("posts")
                                        .document(idUser)
                                        .collection("post_users")
                                        .addDocument(data: [
                                            "description": description,
                                            "url": urlImage
                                        ]) { (error) in
                                            if error == nil{
                                                self.navigationController?.popViewController(animated: true)
                                            }
                                        }
                                }
                            }
                        }
                    })
                    print("Sucesso")
                }else{
                    print("Erro ao fazer upload")
                }
            }
            
            
        }
        
    }
    
    

}

extension ChoosePictureVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let choosedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.pictureImageView.image = choosedImage
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
}
