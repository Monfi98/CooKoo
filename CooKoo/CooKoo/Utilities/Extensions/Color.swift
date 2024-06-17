//
//  Color.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import Foundation
import SwiftUI

extension Color {
    static var backgroundColor: Color = Color(uiColor: UIColor(named: "BackgoundColor")!)

    static var primaryColor: Color = Color(uiColor: UIColor(named: "AccentColor")!)

    static var secondaryColor: Color = .yellow

    static var lightColor: Color = Color(uiColor: UIColor.systemGray6)

    static var labelColor: Color = Color(uiColor: UIColor.label)

    static var listRowColor: Color = Color(uiColor: UIColor.secondarySystemGroupedBackground)
}
