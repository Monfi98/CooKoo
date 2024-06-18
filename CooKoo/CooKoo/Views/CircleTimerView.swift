//
//  CircleTimerView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import Foundation
import SwiftUI
import Combine

struct CircleTimerView: View {

    @Binding var progress: Double
    @Binding var duration: TimeInterval
    @Binding var selectedKeyword: Keyword

    var body: some View {
        
        VStack{
            Text(duration.format(using: [.hour ,.minute, .second]))
                .font(.title2.bold())
                .foregroundColor(Color("AccentColor"))
                .contentTransition(.numericText())
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.08)
                    .foregroundColor(.black)
                    .frame(width: 300, height: 300)
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(270.0))
                    .foregroundColor(Color.primaryColor)
                    .frame(width: 300, height: 300)
                Image(systemName: icon(for: selectedKeyword))
                    .font(.largeTitle)
                    .foregroundColor(Color.labelColor)
            }
        }

    }
    private func icon(for keyword: Keyword) -> String {
         switch keyword {
         case .cook:
             return "frying.pan"
         case .laundry:
             return "washer.fill"
         case .exercise:
             return "figure.cooldown"
         case .study:
             return "text.book.closed.fill"
         }
     }
}
