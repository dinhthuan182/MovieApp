//
//  UIImageView+Extensions.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loadImageUsingCacheWithUrlString(imgName: String) {
        //check cache for image
        if let cacheImage = imageCache.object(forKey: imgName as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        let urlString = "https://image.tmdb.org/t/p/w500/"+imgName
        let requestUrl = URL(string: urlString)
        let request = URLRequest(url:requestUrl!)
        let task = URLSession.shared.dataTask(with: request) {
           (data, response, error) in
           if error != nil {
            print(error!)
            return
           }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: imgName as AnyObject)
                    self.image = downloadedImage
                }
            }
        }
        task.resume()
    }
}
