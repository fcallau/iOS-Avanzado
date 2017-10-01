//
//  ShopDetailViewController.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 12/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController {
    var shop: ModelObject!
    
    @IBOutlet weak var shopDetailDescription: UITextView!
    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var adress: UITextView!
    @IBOutlet weak var mapImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.shop.name
        self.shopDetailDescription.text = String.obtainLiteral(es: self.shop.description_es, en: self.shop.description_en)
        adress.text = self.shop.address
        
        if let data = self.shop.imageData {
            if let image = UIImage(data: data as Data) {
                shopImage.image = image
            }
        }
        
        if let data = self.shop.mapData {
            if let image = UIImage(data: data as Data) {
                mapImage.image = image
            }
        }
    }
}
