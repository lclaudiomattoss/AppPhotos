//
//  GaleryCollectionViewCell.swift
//  PhotoProject
//
//  Created by Luiz Claudio Mattos da Silva on 09/05/22.
//

import UIKit

class GaleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    static let identifier:String = "GaleryCollectionViewCell"
    static func nib()-> UINib{
        return UINib(nibName: self.identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
