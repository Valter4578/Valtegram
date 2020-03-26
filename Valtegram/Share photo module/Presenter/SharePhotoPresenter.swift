//
//  SharePhotoPresenter.swift
//  Valtegram
//
//  Created by Максим Алексеев on 26.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import Firebase

class SharePhotoPresenter: SharePhotoOutput {
    
    weak var view: SharePhotoInput?
    
    func didPressShare(text: String, image: UIImage) {
        if text.count == 0 {
            view?.navigationItem.rightBarButtonItem?.isEnabled = false
        }
        let image = image
        guard let uploadData = image.jpegData(compressionQuality: 0.7) else { return }
        let filename = NSUUID().uuidString
        let reference = Storage.storage().reference().child("posts").child(filename)
        view?.navigationItem.rightBarButtonItem?.isEnabled = false
        reference.putData(uploadData, metadata: nil) { (meta, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            reference.downloadURL { (url, error) in
                guard let url = url else { return }
                self.savePostIntoDatabase(url: url, postImage: image, text: text)
            }
        }
    }
    
    func savePostIntoDatabase(url: URL, postImage: UIImage, text: String) {
        view?.navigationItem.rightBarButtonItem?.isEnabled = false
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let reference = Database.database().reference().child("posts").child(uid)
        
        let text = text
        let values = ["imageUrl":url.absoluteString, "text": text, "imageWidth":postImage.size.width, "imageHeight":postImage.size.height, "date": Date().timeIntervalSince1970] as [String : Any]
        reference.childByAutoId().updateChildValues(values) { (error, reference) in
            if let err = error {
                print(err.localizedDescription)
                self.view?.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            
            print("saved into database")
            self.view?.cancel(animated: true)
        }
        
    }
}
