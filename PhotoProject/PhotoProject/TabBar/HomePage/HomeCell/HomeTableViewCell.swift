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
    
    
    static let identifier:String = "HomeTableViewCell"
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    
}
