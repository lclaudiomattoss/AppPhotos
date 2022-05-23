//
//  HomeTableViewCell.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 09/05/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    
    static let identifier:String = "HomeTableViewCell"
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    public func maskCircle(){
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.maskCircle()
        self.heartButton.tintColor = UIColor.myColor
    }
    
    @IBAction func tappedHeartButton(_ sender: UIButton) {
        if self.heartButton.tintColor == UIColor.myColor{
            self.heartButton.tintColor = UIColor.red
        }else{
            self.heartButton.tintColor = UIColor.myColor
        }
    }
    
    
}
