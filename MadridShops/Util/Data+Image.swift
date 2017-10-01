//
//  Data+Image.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 28/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

// import Foundation
import UIKit

extension Data {
    func loadImage(into imageView: UIImageView) {
        let queue = OperationQueue()
        queue.addOperation {
            if let image = UIImage(data: self) {                
                OperationQueue.main.addOperation {
                    imageView.image = image
                }
            }
        }
    }
    
    func loadImageInUIView(into view: UIView) {
        let queue = OperationQueue()
        queue.addOperation {
            if let image = UIImage(data: self) {
                OperationQueue.main.addOperation {
                    view.addSubview(UIImageView(image: image))
                }
            }
        }
    }
}

