//
//  UserTableViewCell.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 09/05/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    static let identifier:String = "UserTableViewCell"
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
