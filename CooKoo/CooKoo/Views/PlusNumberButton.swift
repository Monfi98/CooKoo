//
//  PlusNumberButton.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import Foundation
import SwiftUI

struct PlusNumberButton: View {
    let number: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(number)
                .padding()
                .frame(width: 100, height: 50)
                .background(Color.green)
                .foregroundColor(.white)
                //.cornerRadius(25)
        }
        //.padding()
    }
}
