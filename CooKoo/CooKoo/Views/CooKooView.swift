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
    
    var body: some View {
        
        VStack(alignment:.center, spacing: 30){
            Text("Coo - Koo !")
                .padding(.top, 35)
                .padding(.bottom, 20)
                //.font(.largeTitle)
                .font(Font.system(size: fontSize, weight: .heavy))
                .tracking(2) // 자간
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
            .padding(.vertical, 20)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
    
    }
}
