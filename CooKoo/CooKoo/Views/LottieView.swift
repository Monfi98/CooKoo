//
//  LottieView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/19/24.
//

import Lottie
import Foundation
import UIKit
import SwiftUI

struct LottieView: UIViewRepresentable {
    
    var animationFileName: String
    let loopMode: LottieLoopMode
    var contentMode: UIView.ContentMode = .scaleAspectFit // 콘텐츠 모드 추가
    var width: CGFloat
    var height: CGFloat
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: animationFileName)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = contentMode
        animationView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
}

