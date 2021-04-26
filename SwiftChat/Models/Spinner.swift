//
//  Spinner.swift
//  SwiftChat
//
//  Created by Mikhail on 25.04.2021.
//

import UIKit

fileprivate var aView: UIView?

extension StartViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = .white
        aView?.alpha = 0.4
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
}
