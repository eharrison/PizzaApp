//
//  UIViewControllerExtensions.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 9/20/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import UIKit
import SafariServices

// MARK: - Safari Extensions

extension UIViewController: SFSafariViewControllerDelegate {
    
    func presentWebPageInSafari(withURLString URLString: String) {
        guard let url = URL(string: URLString) else{
            return
        }
        
        presentWebPageInSafari(withURL: url)
    }
    
    func presentWebPageInSafari(withURL url: URL) {
        guard UIApplication.shared.canOpenURL(url) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
