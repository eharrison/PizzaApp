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
    
    func showAlert(withTitle title: String? = nil, message: String?,  completion: (() -> ())? = nil, buttons: (UIAlertAction.Style, String, (() -> ())?)...) {
        
        guard let message = message, message.count > 0 else {
            return
        }
        
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            //alertController.modalPresentationStyle = isPad ? .popover : .currentContext
            
            for button in buttons {
                alertController.addAction(UIAlertAction(title: button.1, style: button.0) { (_: UIAlertAction!) in
                    if let completion = completion { completion() }
                    if let actionBlock = button.2 { actionBlock() }
                })
            }
            self.present(alertController, animated: true, completion: nil)
        } else {
            // Handle prior iOS Versions
            
        }
    }
    
}
