//
//  CollectionViewCell.swift
//  ImageSearch
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ImageItemCell: UICollectionViewCell {
    
    //MARK: outlets
    @IBOutlet weak var contentImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
            contentImageView.image = nil
            
    }
}
