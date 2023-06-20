//
//  SWStatesHUDItem.swift
//  
//
//  Created by Steve on 2023/6/16.
//

import SwiftUI

public struct SWStatesHUDItem: Identifiable {
    static var currentItemID: UUID?
    
    public let id: UUID = .init()
    
    let type: SWStatesHUDType
    let message: LocalizedStringKey?
    let dismissAfter: TimeInterval?
    let completion: (() -> Void)?
    
    public init(type: SWStatesHUDType,
                message: LocalizedStringKey? = nil,
                dismissAfter: TimeInterval? = nil,
                completion: (() -> Void)? = nil) {
        self.type = type
        self.message = message
        self.dismissAfter = dismissAfter
        self.completion = completion
    }
}
