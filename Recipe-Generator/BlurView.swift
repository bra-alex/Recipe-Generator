//
//  BlurView.swift
//  Recipe-Generator
//
//  Created by Don Bouncy on 28/02/2023.
//

import SwiftUI

struct BlurView: UIViewRepresentable{
    var effect: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
