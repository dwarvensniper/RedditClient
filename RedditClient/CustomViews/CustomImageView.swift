//
//  CustomImageView.swift
//  RedditClient
//
//  Created by erwin robles jr on 12/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//

import UIKit

let imageCahched = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView{
    
   var task: URLSessionDataTask!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadImage(with url: URL){
        
        
        if let task = task{
            task.cancel()
        }
        
        if let imageCache = imageCahched.object(forKey: url.absoluteString as AnyObject) as? UIImage{
            self.image = imageCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("loadImage", error)
                return
            }
            let imageToCache = UIImage(data: data!)
            imageCahched.setObject(imageToCache!, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = imageToCache
            }
        }.resume()
    }
}
