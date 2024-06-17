//
//  timerButtonStyle.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import Foundation
import SwiftUI

extension View {
    func timerButtonStyle(isValid: Bool = true) -> some View {
        self
            .font(.title2)
            .padding()
            .background(Color.primaryColor.opacity(isValid ? 1.0 : 0.2))
            .foregroundColor(Color.labelColor)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}
