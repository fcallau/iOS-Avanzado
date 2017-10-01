//
//  String+Image.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 12/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import UIKit
import MapKit

extension String {
    func loadImage(into imageView: UIImageView) {
        let queue = OperationQueue()
        queue.addOperation {
            if let url = URL(string: self),
                let data = NSData(contentsOf: url),
                let image = UIImage(data: data as Data) {
                
                OperationQueue.main.addOperation {
                    imageView.image = image
                }
            }
        }
    }
    
    //    func loadImageWithNSURLSession(into imageView: UIImageView) {
    //        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    //        let imageViewCenterPoint: CGPoint = CGPoint(x: imageView.frame.width / 2, y: imageView.frame.height / 2)
    //        activityIndicator.center = imageViewCenterPoint
    //        activityIndicator.hidesWhenStopped = true
    //        activityIndicator.startAnimating()
    //        imageView.addSubview(activityIndicator)
    //
    //        let defaultSession = URLSession(configuration: .default)
    //        let dataTask: URLSessionDataTask?
    //
    //        if let url = URL(string: self) {
    //            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
    //                if let error = error {
    //                    print("Error loading image with NSURLSession. Error: \(error)")
    //                } else if let myData = data {
    //                    assert(Thread.current != Thread.main)
    //                    DispatchQueue.main.async {
    //                        assert(Thread.current == Thread.main)
    //                        activityIndicator.stopAnimating()
    //                        imageView.image = UIImage(data: myData)
    //                    }
    //                }
    //            })
    //
    //            dataTask?.resume()
    //        }
    //    }
}
