//
//  PhotoSelectorPresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Photos
import UIKit

class PhotoSelectorPresenter: PhotoSelectorOutput {
    
    var images = [UIImage]()
    var selectedImage: UIImage?
    var assets = [PHAsset]()

    
    func fetchPhotos(complitionHandler: @escaping () -> ()) {
        let options = PHFetchOptions()
        options.fetchLimit = 100
        let allPhotos = PHAsset.fetchAssets(with: .image, options: options)
        
        DispatchQueue.global(qos: .userInitiated).async {
            allPhotos.enumerateObjects { (asset, count, stop) in
                print(count)
                let imageManager = PHImageManager.default()
                let targetSize = CGSize(width: 100, height: 100)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options) { (image, info) in
                    
                    guard let img = image else { return }
                    self.images.append(img)
                    self.assets.append(asset)
                    if self.selectedImage == nil {
                        self.selectedImage = img
                    }
                    
                    
                    if count == allPhotos.count - 1 {
                        DispatchQueue.main.async {
                            complitionHandler()
                        }
                    }
                }
            }
        }
    }
}
