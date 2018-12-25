//
//  UIImageViewExtension.swift
//  TumblrApp
//
//  Created by Alex on 22.12.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import UIKit

final class ImageCacher {
    
    static let shared = ImageCacher()
    
    var cachableElements = NSCache<AnyObject, AnyObject>()
    
    func saveImage(image: UIImage, key: String) {
        ImageCacher.shared.cachableElements.setObject(image, forKey: key as AnyObject)
    }
    
    func loadImage(key: String) -> UIImage? {
        return ImageCacher.shared.cachableElements.object(forKey:key as AnyObject) as? UIImage
    }
    
    func removeFromCache(key: String) {
        ImageCacher.shared.cachableElements.removeObject(forKey: key as AnyObject)
    }
}

extension UIImageView {
    
    func loadImage(urlString: String, in cell: UITableViewCell, at indexPath: IndexPath) {
        imageFromServerURL(urlString: urlString) { [weak self] image in
            if cell.tag == indexPath.row {
                self?.image = image
            }
        }
    }
    
    func loadImage(urlString: String, comletion: (() -> ())? = nil) {
        imageFromServerURL(urlString: urlString) { [weak self] image in
            self?.image = image
        }
    }
}

private extension UIImageView {
    func imageFromServerURL(urlString: String, comletion: ((UIImage) -> ())? = nil) {
        
        image = #imageLiteral(resourceName: "noImageIcon")
        
        guard let url = URL(string: urlString) else { return }
        
        if let image = ImageCacher.shared.loadImage(key: urlString) {
            comletion?(image)
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            let data = try?  Data(contentsOf: url)
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    comletion?(image)
                    ImageCacher.shared.saveImage(image: image, key: urlString)
                }
            }
        }
    }
}

