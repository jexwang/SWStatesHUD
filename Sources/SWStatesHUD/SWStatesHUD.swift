//
//  SWStatesHUD.swift
//  
//
//  Created by Steve on 2023/6/16.
//

import SwiftUI

struct SWStatesHUD: View {
    let item: SWStatesHUDItem
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
            
            hud
        }
        .ignoresSafeArea()
    }
    
    private var hud: some View {
        VStack(spacing: 8) {
            switch item.type {
            case .loading:
                ProgressView()
                    .controlSize(.large)
            case .success:
                Image(systemName: "checkmark")
                    .font(.largeTitle)
            case .failure:
                Image(systemName: "xmark")
                    .font(.largeTitle)
            case .custom(let view):
                view
            }
            
            if let message = item.message {
                Text(message)
            }
        }
        .tint(.primary)
        .foregroundColor(.primary)
        .padding()
        .background(
            Color(uiColor: .systemGray5)
        )
        .cornerRadius(16)
        .shadow(radius: 8)
        .padding()
    }
}

struct SWStatesHUD_Previews: PreviewProvider {
    static let item: SWStatesHUDItem = .init(type: .custom(AnyView(customView)), message: "Loading...")
    
    static var previews: some View {
        SWStatesHUD(item: item)
    }
    
    static var customView: some View {
        Image(systemName: "phone")
            .font(.largeTitle)
    }
}
