//
//  SearchVC.swift
//  ImageSearch
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit
import AlamofireImage

class SearchVC: UIViewController {

    //MARK: variables
    var searchImagesList = [ImageInfo]()
    
    //MARK: outlets
    @IBOutlet weak var searchItem: UISearchBar!

    @IBOutlet weak var initialLabel: UILabel!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //ImageItemCell nib registry
        let imageItemNib = UINib(nibName: "ImageItemCell", bundle: nil)
        imagesCollectionView.register(imageItemNib, forCellWithReuseIdentifier: "ImageItemCellID")
      
        //setting up delegate and datasource
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        searchItem.delegate = self
        initialLabel.isHidden = false
        
        //setting up itemCell layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: imagesCollectionView.frame.width/2 - 1, height: 120)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        flowLayout.scrollDirection = .vertical
        imagesCollectionView.collectionViewLayout = flowLayout
        
       // searchButton.addTarget(self, action: #selector(searchQuery), for: .touchUpInside)
        
        
    }

}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return searchImagesList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        initialLabel.isHidden = true
        guard let imageItem = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageItemCellID", for: indexPath) as? ImageItemCell else{ fatalError("Item Not Found")
        }
        
        if let url = URL(string: searchImagesList[indexPath.item].previewURL){
            
         imageItem.contentImageView.af_setImage(withURL : url)
            
        }
        
        return imageItem
    }
    
    //item selcted at index path
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailedImagePage = self.storyboard?.instantiateViewController(withIdentifier: "DetailedImageID") as! DetailedImageVC
        self.navigationController?.pushViewController(detailedImagePage, animated: true)
        
        guard let imageItem = collectionView.cellForItem(at: indexPath) as? ImageItemCell else{ return }
        
        if let url = URL(string: searchImagesList[indexPath.item].previewURL){
            
            imageItem.contentImageView.af_setImage(withURL : url)
            
        }
        
        detailedImagePage.imageId = searchImagesList[indexPath.item].id
        detailedImagePage.expandedImage = imageItem.contentImageView.image
    }
    
}

//MARK: UISearchBarDelegate
extension SearchVC: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        searchBar.endEditing(true)
        initialLabel.isHidden = true
        
       let searchText = searchBar.text ?? " "
            Webservices().fetchDataFromPixabay(withQuery: searchText,
                                               success: { (images : [ImageInfo]) in
                    
                    self.searchImagesList = images
                    self.imagesCollectionView.reloadData()
            
            }) { (error : Error) in
                print(error)
                
            }

            
        }
}
