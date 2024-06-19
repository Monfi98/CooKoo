//
//  WidgetCircleTimerView.swift
//  CooKooWidgetExtension
//
//  Created by Minjung Lee on 6/17/24.
//

import SwiftUI

struct WidgetProgressBarView: View {
    
    var progress: Double
    var duration: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            // 배경 바
            Rectangle()
                .frame(width: 300, height: 12)
                .opacity(0.6)
                .foregroundColor(Color("CooKooGray"))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)

            HStack {
                // 프로그레스 바
                Rectangle()
                    .frame(width: 300 - progress * 300, height: 12) // progress 비율에 따른 너비 설정
                    .foregroundColor(Color("AccentColor"))
                    .cornerRadius(12)

                ZStack(alignment: .center){
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                        .overlay(
                            Circle()
                                .stroke(Color("AccentColor"), lineWidth: 3) // 테두리 설정
                        )

                    Image(systemName: "play.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(Color("AccentColor"))
                        .padding(.leading, 2)
                }
                .padding(.leading, -20)
                .opacity(progress == 0 ? 0 : 1)
            }
        }
        .padding(10)
        .frame(width: 320, height: 30) // 프로그레스 바 전체 크기
        .cornerRadius(12)
        
        
        
    }
    
    
}

//#Preview {
//    WidgetCircleTimerView(progress: 0.8, duration: "2:41")
//}
