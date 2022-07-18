//
//  WebImageView.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 18.07.2022.
//

import UIKit

final class WebImageView: UIImageView {
    
    static let imageDownloadSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        URLCache.shared = URLCache(memoryCapacity: 50 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: "images")
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }()
    
    func loadImage(url: String) {
        WebImageView.imageDownloadSession.dataTask(with: URL(string: url)!) { [weak self] data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.image = nil
                }
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
