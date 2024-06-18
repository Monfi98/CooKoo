//
//  NumberButton.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import Foundation
import SwiftUI

struct NumberButton: View {
    let number: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(number)
                .padding()
                .frame(width: 80, height: 50)
                .foregroundColor(.black)
                .cornerRadius(25)
        }
        .padding()
    }
}
