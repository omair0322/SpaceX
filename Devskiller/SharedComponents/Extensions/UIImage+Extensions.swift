//
//  UIImage+Extensions.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import UIKit

extension UIImageView {

    func setImage(from url: URL, placeholder: PlaceholderImage = .default, cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>(), completion: ((UIImage) -> Void)? = nil) {
        self.image = placeholder.image
        
        // Check if the image is already in cache
        let cacheKey = NSString(string: url.absoluteString)
        if let cachedImage = cache.object(forKey: cacheKey) {
            self.image = cachedImage
            completion?(cachedImage)
            return
        }
        
        ImageDownloader().downloadImage(from: url) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                let finalImage: UIImage
                switch result {
                case .success(let downloadedImage):
                    self.image = downloadedImage
                    cache.setObject(downloadedImage, forKey: cacheKey)
                    finalImage = downloadedImage
                case .failure:
                    self.image = placeholder.image
                    finalImage = placeholder.image
                }
                
                completion?(finalImage)
            }
        }
    }
}
