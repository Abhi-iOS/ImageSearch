//
//  DetailedImageVC.swift
//  ImageSearch
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class DetailedImageVC: UIViewController {

    //MARK: variable
    var expandedImage : UIImage? = nil
    var imageId = ""
    
    //MARK: outlet
    @IBOutlet weak var imageIdLabel: UILabel!
    
    @IBOutlet weak var detailedImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageIdLabel.text = imageId
        detailedImageView.image = expandedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
}
