//
//  TRCollectionViewController.swift
//  snapchatDiscover
//
//  Created by Vladimir Valter on 23/03/2017.
//  Copyright © 2017 Vladimir Valter. All rights reserved.
//

import UIKit
import TRMosaicLayout
import Alamofire
import AlamofireImage

private let reuseIdentifier = "MosaicCell"

class TRCollectionViewController: UICollectionViewController {
    
    var images = [UIImage()]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let mosaicLayout = TRMosaicLayout()
        self.collectionView?.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
        
        fetchImages()

        
    }

    func fetchImages() {
        
        Alamofire.request(BASE_URL, method: .get).responseImage { response in
            guard let image = response.result.value else {
                // Handle error
                return
            }
            self.images.append(image)
        }
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 100
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        if !images.isEmpty {
            let imageView = UIImageView()
            imageView.af_setImage(withURL: url, placeholderImage: nil, filter: nil)
            
            //setImageWith(URL(string: images[indexPath.item % images.count])!, placeholderImage: nil)
            imageView.frame = cell.frame
            cell.backgroundView = imageView
        }
    
        return cell
    }


} // class


extension TRCollectionViewController: TRMosaicLayoutDelegate {
    
    func collectionView(_ collectionView:UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath:IndexPath) -> TRMosaicCellType {
        return indexPath.item % 3 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return 150
    }
}
