//
//  TimeFieldView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import Foundation
import SwiftUI

struct TimeFieldView: View {
    let field: TimeField
    let value: Int
    @Binding var activeField: TimeField
    
    var body: some View {
        Text(String(format: "%02d", value))
            .padding()
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(Color("CooKooBlack"))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("CooKooShadow"))
                    .opacity(activeField == field ? 1.0 : 0.0) // active 상태에서만 색깔보이게
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .onTapGesture {
                if activeField == field {
                    activeField = .none
                } else {
                    activeField = field
                }
            }
    }
}
