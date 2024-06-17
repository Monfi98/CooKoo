//
//  Color.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import Foundation
import SwiftUI

extension Color {
    /// Primary color used in app
    static var backgroundColor: Color = Color(uiColor: UIColor(named: "BackgoundColor")!)

    static var primaryColor: Color = Color(uiColor: UIColor(named: "AccentColor")!)

    /// Secondary color used in app
    static var secondaryColor: Color = .yellow

    /// Light gray color
    static var lightColor: Color = Color(uiColor: UIColor.systemGray6)

    /// Gray color for placeholders, lines .. etc
    static var labelColor: Color = Color(uiColor: UIColor.label)
    
    /// List row color
    static var listRowColor: Color = Color(uiColor: UIColor.secondarySystemGroupedBackground)
}
