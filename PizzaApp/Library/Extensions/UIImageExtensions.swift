//
//  UIImageExtensions.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 19/9/18.
//  Copyright © 2018 ItsDayOff. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public func setImage(_ urlString: String?, completion:((UIImage?) -> Void)? = nil) {
        self.layer.masksToBounds = true
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion?(nil)
            return
        }
        
        self.image = nil
        
        self.startShimmerAnimation()
        
        DispatchQueue.global().async {
            do {
                let data = try Data.init(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.stopShimmerAnimation()
                    self.image = UIImage(data: data)
                    completion?(self.image)
                }
            } catch {
                DispatchQueue.main.async {
                    self.stopShimmerAnimation()
                    completion?(nil)
                }
            }
        }
        
    }
    
}
