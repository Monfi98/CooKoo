//
//  CooKooView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/18/24.
//

import Foundation
import SwiftUI
import Combine

struct CooKooView: View {
    @State private var scale: CGFloat = 0.1
    @State private var fontSize = 10.0
    
    let fireworksCount = 30 // 폭죽 이미지 개수
    let animationDuration = 3.0 // 애니메이션 지속 시간
    
    var body: some View {
        ZStack(alignment: .top){
            // MARK: - 폭죽
            ForEach(0..<fireworksCount) { index in
                FireworkParticle()
            }
            
            VStack(alignment:.center, spacing: 30){
                Text(" Coo-Koo!")
                    .padding(.top, 35)
                    .padding(.bottom, 20)
                    .font(Font.system(size: fontSize, weight: .heavy))
                    .tracking(3) // 자간
                    .foregroundStyle(Color("AccentColor"))
                    .contentTransition(.numericText())
                    .onAppear(){
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1).repeatCount(1)) {
                            fontSize = 35.0
                        }
                    }
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.08)
                        .foregroundColor(.black)
                        .frame(width: 330, height: 330)
                        .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
                    Circle()
                        .trim(from: 0.0, to: 1.0)
                        .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(270.0))
                        .foregroundColor(Color("AccentColor"))
                        .frame(width: 330, height: 330)
                    
                    LottieView(loopMode: .loop, jsonName: "cookooLottie")
                        .frame(width: 330, height: 330)
                        .scaleEffect(scale)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                scale = 0.33
                            }
                        }
                }
                .padding(.top, 20)
            }
            .padding(.top, 20)
            .padding(.horizontal, 10)
        }
        .padding(0)
        .edgesIgnoringSafeArea(.horizontal)
    }
}

struct FireworkParticle: View {
    @State private var position: CGPoint = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                                   y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
    @State private var opacity: Double = 1.0
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Image("congrat") // 폭죽 이미지 이름
            .resizable()
            .frame(width: 130, height: 130)
            .position(position)
            .opacity(opacity)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(Animation.linear(duration: 2.0)) {
                    self.position = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                            y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                    self.opacity = 0.0
                    self.scale = CGFloat.random(in: 0.5...1.5)
                }
            }
    }
}
