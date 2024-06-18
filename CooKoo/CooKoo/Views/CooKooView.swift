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

    var body: some View {
        VStack(alignment:.center, spacing: 30){
            Text("Coo - Koo !")
                .padding(.top, 35)
                .padding(.bottom, 20)
                //.font(.largeTitle)
                .font(Font.system(size: 35, weight: .heavy))
                .tracking(2) // 자간
                .foregroundStyle(Color("CooKooBlack"))
                .contentTransition(.numericText())
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
                Image("cookoo")
                    .resizable()
                    .frame(width: 200, height: 200, alignment: .center)
            }
            .padding(.vertical, 20)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
    
    }
}
