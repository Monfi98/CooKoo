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
                .padding(10)
                .font(.system(size: 23))
                .frame(width: 80, height: 20)
                .foregroundColor(Color("CooKooBlack"))
        }
        .padding()
    }
}
