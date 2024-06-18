//
//  TimeInterval.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import SwiftUI
import Foundation

extension TimeInterval {
    func format(using units: NSCalendar.Unit) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: self) ?? ""
    }
}
