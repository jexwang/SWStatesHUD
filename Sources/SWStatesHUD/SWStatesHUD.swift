//
//  SWStatesHUD.swift
//  
//
//  Created by Steve on 2023/6/16.
//

import SwiftUI

public struct SWStatesHUD: View {
    let item: SWStatesHUDItem
    
    @State private var opacity: Double = 1
    
    public var body: some View {
        ZStack {
            Color.black
                .opacity(0.4)
            
            hud
        }
        .opacity(opacity)
        .ignoresSafeArea()
        .onAppear {
            if item.animated, let dismissAfter = item.dismissAfter {
                withAnimation(
                    .linear(duration: SWStatesHUDItem.animationDuration)
                    .delay(dismissAfter)
                ) {
                    opacity = 0
                }
            }
        }
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

extension SWStatesHUD {
    public static func show(item: SWStatesHUDItem) {
        guard item.id != SWStatesHUDItem.currentItemID else { return }
        
        let statesHUD = Self(item: item)
        UIWindow.instanceForStatesHUD = UIWindow(view: statesHUD)
        
        if let dismissTimeInterval = item.dismissAfter {
            var timeInterval = item.animated ? SWStatesHUDItem.animationDuration : 0
            timeInterval += dismissTimeInterval
            
            Timer.scheduledTimer(
                withTimeInterval: timeInterval,
                repeats: false
            ) { _ in
                Self.dismiss()
                item.completion?()
            }
        }
        
        SWStatesHUDItem.currentItemID = item.id
    }
    
    public static func dismiss() {
        UIWindow.instanceForStatesHUD = nil
        SWStatesHUDItem.currentItemID = nil
    }
}

struct SWStatesHUD_Previews: PreviewProvider {
    static let item: SWStatesHUDItem = .init(type: .custom(AnyView(customView)), message: "Loading...")
    
    static var previews: some View {
        SWStatesHUD(item: item)
    }
    
    static var customView: some View {
        Image(systemName: "circle.dotted")
            .font(.largeTitle)
    }
}
