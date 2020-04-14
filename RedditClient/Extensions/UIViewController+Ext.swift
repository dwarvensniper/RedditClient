//
//  UIViewController+Ext.swift
//  RedditClient
//
//  Created by erwin robles jr on 11/04/2020.
//  Copyright © 2020 sample organization. All rights reserved.
//
import UIKit

extension UIViewController{
    
    func showAlert(message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func hideKeyboardObserver(){
        
    }
    
}
