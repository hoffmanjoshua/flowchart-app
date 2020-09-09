//
//  Blur.swift
//  Flowchart
//
//  Source: https://gist.github.com/edwurtle/98c33bc783eb4761c114fcdcaac8ac71#file-blur-swift
//


import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
