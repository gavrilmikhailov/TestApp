//
//  ImageViewerViewController.swift
//  TestApp
//
//  Created by Гавриил Михайлов on 18.07.2022.
//

import UIKit

protocol ImageViewerViewDelegate: AnyObject {
    
    func close()
}

final class ImageViewerViewController: UIViewController {
    
    private let image: UIImage
    
    private lazy var customView = view as? ImageViewerView
    
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ImageViewerView(image: self.image, delegate: self)
    }
}

extension ImageViewerViewController: ImageViewerViewDelegate {
    
    func close() {
        presentingViewController?.dismiss(animated: true)
    }
}
