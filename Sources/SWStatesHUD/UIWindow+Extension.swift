//
//  UIWindow+Extension.swift
//  
//
//  Created by Steve on 2023/6/16.
//

import SwiftUI

extension UIWindow {
    static var instanceForStatesHUD: UIWindow?
    
    convenience init(view: some View) {
        if let scene = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }).first as? UIWindowScene {
            self.init(windowScene: scene)
        } else {
            self.init(frame: UIScreen.main.bounds)
        }
        
        windowLevel = .alert - 1 // Doesn't work with SwiftUI alert
        
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.backgroundColor = .clear
        rootViewController = hostingController
        
        makeKeyAndVisible()
    }
}
