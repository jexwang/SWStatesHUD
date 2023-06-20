//
//  View+Extension.swift
//  
//
//  Created by Steve on 2023/6/16.
//

import SwiftUI

public extension View {
    func states(item: Binding<SWStatesHUDItem?>) -> some View {
        guard item.wrappedValue?.id != SWStatesHUDItem.currentItemID else {
            return self
                .disabled(item.wrappedValue != nil)
        }
        
        if let unwrappedItem = item.wrappedValue {
            let statesHUD = SWStatesHUD(item: unwrappedItem)
            UIWindow.instanceForStatesHUD = UIWindow(view: statesHUD)
            
            if let dismissTimeInterval = unwrappedItem.dismissAfter {
                Timer.scheduledTimer(withTimeInterval: dismissTimeInterval, repeats: false) { _ in
                    item.wrappedValue = nil
                    unwrappedItem.completion?()
                }
            }
            
            SWStatesHUDItem.currentItemID = unwrappedItem.id
        } else {
            UIWindow.instanceForStatesHUD = nil
            SWStatesHUDItem.currentItemID = nil
        }
        
        return self
            .disabled(item.wrappedValue != nil)
    }
}
