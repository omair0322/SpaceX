//
//  ImageDownloader.swift
//  Devskiller
//
//  Created by Muhammad Omair on 09/04/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ImageDownloader {
    init() {}

    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, ImageDownloadError>) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    
                    print("Invalid image data.\(url)")
                    completion(.failure(.invalidData))
                }
            case .failure(let error):
                print("Download error: \(error.localizedDescription)")
                completion(.failure(.networkError))
            }
        }
    }
}

