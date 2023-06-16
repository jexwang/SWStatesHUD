//
//  View+Extension.swift
//  
//
//  Created by Steve on 2023/6/16.
//

import SwiftUI

public extension View {
    func states(item: Binding<SWStatesHUDItem?>) -> some View {
        if let unwrappedItem = item.wrappedValue {
            let statesHUD = SWStatesHUD(item: unwrappedItem)
            UIWindow.instanceForStatesHUD = UIWindow(view: statesHUD)
            
            if let dismissTimeInterval = unwrappedItem.dismissAfter {
                Timer.scheduledTimer(withTimeInterval: dismissTimeInterval, repeats: false) { _ in
                    unwrappedItem.completion?()
                    item.wrappedValue = nil
                }
            }
        } else {
            UIWindow.instanceForStatesHUD = nil
        }
        
        return self
            .disabled(item.wrappedValue != nil)
    }
}
