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
            
            ZStack(alignment: .center){
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color("CooKooWhite"))
                    .frame(width: 75, height: 32)
                    .overlay(
                        Group {
                            RoundedRectangle(cornerRadius: 26)
                                .stroke(Color("CooKooGray"), lineWidth: 1)
                        }
                    )
                Text(number)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("CooKooGray"))
            }
        }
    }
}


