//
//  BannerAlert.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/20/24.
//

import Foundation
import SwiftUI

struct BannerAlert: View {
    var title: String
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            if showAlert {
                ZStack(alignment: .center){
                    Rectangle()
                        .frame(width: 340, height: 70)
                        .foregroundColor(Color("CooKooWhite").opacity(0.4))
                        .cornerRadius(12)
                    Text(title)
                        .foregroundColor(.red)
                        .padding()
                        .font(Font.title3)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                .background(Color("Background"))
                .transition(.move(edge: .bottom))
                .offset(x: 0, y: 10)// 하단에서 위로 이동하는 애니메이션
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                        withAnimation {
                            showAlert = false
                        }
                    }
                }
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

