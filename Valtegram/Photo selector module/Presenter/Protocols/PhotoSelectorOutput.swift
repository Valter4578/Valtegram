//
//  PhotoSelectorOutput.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Photos
import UIKit

protocol PhotoSelectorOutput: class {
    var images: [UIImage] { get set }
    var selectedImage: UIImage? { get set }
    var assets: [PHAsset] { get set }
    
    func fetchPhotos(complitionHandler: @escaping () -> ())
}
