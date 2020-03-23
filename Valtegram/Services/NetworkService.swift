//
//  NetworkService.swift
//  Valtegram
//
//  Created by Максим Алексеев on 22.03.2020.
//  Copyright © 2020 Максим Алексеев. All rights reserved.
//

import UIKit

class NetworkService {
    var complitionHandler: ((Data) -> UIImage)!
    
    func getImageFrom(_ url: URL, complitionHandler: @escaping ((Data) -> UIImage) ) {
        self.complitionHandler = complitionHandler
         
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
            
                complitionHandler(data)
            }
        }.resume()
    }
}
