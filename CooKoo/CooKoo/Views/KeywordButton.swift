//
//  KeywordButton.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/18/24.
//

import Foundation
import SwiftUI

struct KeywordButton: View {
    let selectedKeyword: Keyword
    let currentKeyword: Keyword
    let keywordImage: String
    let action: () -> Void
    let widthValue: CGFloat
    let heightValue: CGFloat
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(selectedKeyword == currentKeyword ? Color.accentColor : Color("CooKooWhite"))
                    .frame(width: 80, height: 68)
                    .overlay(
                        Group {
                            if selectedKeyword != currentKeyword {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("CooKooGray"), lineWidth: 1.6)
                            }
                        }
                    )
                Image(systemName: keywordImage)
                    .resizable()
                    .frame(width: widthValue, height: heightValue)
                    .foregroundColor(selectedKeyword == currentKeyword ? Color("CooKooWhite") : Color("CooKooGray"))
            }
        }
    }
}
