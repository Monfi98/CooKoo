//
//  Color.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import Foundation
import SwiftUI

extension Color {
    // 원하는 변수 : assest 이름
    
    static var backgroundColor: Color = Color("Background")
    
    static var accentColor: Color = Color("AccentColor")
    
    static var semiBlackColor: Color = Color("CooKooSemiBlack")
    
    static var grayColor: Color = Color("CooKooGray")
    
    //static var cooKooBlack: Color = Color(uiColor: UIColor(named: "CooKooBlack")!)

    static var primaryColor: Color = Color(uiColor: UIColor.systemMint)

    static var secondaryColor: Color = Color(uiColor: UIColor.systemMint)

    static var lightColor: Color = Color(uiColor: UIColor.systemMint)

    static var labelColor: Color = Color(uiColor: UIColor.label)

    static var listRowColor: Color = Color(uiColor: UIColor.secondarySystemGroupedBackground)
    
    
}
