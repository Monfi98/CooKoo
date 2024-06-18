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
        
        VStack{
            Text("Coo - Koo !")
                .font(.title2.bold())
                .foregroundColor(Color.labelColor)
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.08)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 300)
                Circle()
                    .trim(from: 0.0, to: 1.0)
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(270.0))
                    .foregroundColor(Color.primaryColor)
                    .frame(width: 300, height: 300)
                Image("cookoo")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
            }
            Button(action: {
                print("fin")
            }, label: {
                Text("restart")
                    .padding()
                    .foregroundColor(.black)
                    .cornerRadius(8)
            })
        }

    }
}
