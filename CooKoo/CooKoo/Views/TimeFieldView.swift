//
//  TimeFieldView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import Foundation
import SwiftUI

struct TimeFieldView: View {
    let field: ContentView.TimeField
    let value: Int
    @Binding var activeField: ContentView.TimeField

    var body: some View {
        Text(String(format: "%02d", value))
            .padding()
            .background(activeField == field ? Color.yellow : Color.clear)
            .onTapGesture {
                if activeField == field {
                    activeField = .none
                } else {
                    activeField = field
                }
            }
    }
}
