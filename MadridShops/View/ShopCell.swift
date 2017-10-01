//
//  ShopCell.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 8/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import UIKit

class ShopCell: UICollectionViewCell {
    var shop: ModelObject?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func refresh(shop: ModelObject) {
        self.shop = shop
        
        self.label.text = shop.name
        
        if let imgData = self.shop?.logoData {
            (imgData as Data).loadImage(into: imageView)
        }
        
        imageView.clipsToBounds = true
        UIView.animate(withDuration: 1.0) {
            self.imageView.layer.cornerRadius = 25
        }
    }
}
