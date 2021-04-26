//
//  CustomizingNavigationBar.swift
//  SwiftChat
//
//  Created by Mikhail on 23.04.2021.
//

import UIKit

extension ChatsTableViewController {
    
    func updateNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let shadowView = self.navigationController!.navigationBar
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
            shadowView.standardAppearance = navBarAppearance
            shadowView.scrollEdgeAppearance = navBarAppearance
        }
        
        shadowView.prefersLargeTitles = true
        shadowView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadowView.layer.shadowOpacity = 0.38
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowRadius = 7
    }
}
