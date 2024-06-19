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
        VStack(alignment:.center, spacing: 30){
            Text(duration.format(using: [.hour ,.minute, .second]))
                .padding(.top, 35)
                .padding(.bottom, 20)
                //.font(.largeTitle)
                .font(Font.system(size: 35, weight: .bold))
                .tracking(4) // 자간
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
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(270.0))
                    .foregroundColor(Color("AccentColor"))
                    .frame(width: 330, height: 330)

                Image(systemName: icon(for: selectedKeyword))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .font(.largeTitle)
                    .foregroundColor(Color("CooKooGray"))
                    .frame(width: 110, height: 110)
                    .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 2)
            }
            .padding(.vertical, 20)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 10)
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



