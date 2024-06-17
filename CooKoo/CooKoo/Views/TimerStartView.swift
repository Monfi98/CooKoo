//
//  TimerStartView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/16/24.
//

import SwiftUI

struct TimerStartView: View {
    @ObservedObject var viewModel: TimerStartViewModel
    @State private var timerCompleted: Bool = false
    
    
    // TODO: viewmodel로 옮겨야 함
//    @Binding var progress: Double
//    @Binding var duration: TimeInterval
    
    
    var body: some View {
        VStack {
            Text("Starting timer for \(viewModel.state.selectedKeyword)")
                .font(.largeTitle)
                .padding()
            
            Text(viewModel.timeString)
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .padding()
        }
        
//        
//        ZStack {
//            Circle()
//                .stroke(lineWidth: 20)
//                .opacity(0.08)
//                .foregroundColor(.black)
//                .frame(width: 200, height: 200)
//
//            Circle()
//                .trim(from: 0.0, to: progress)
//                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
//                .rotationEffect(.degrees(270.0))
//                .foregroundColor(Color.blue)
//                .frame(width: 200, height: 200)
//
//            Text(duration.format(using: [.minute, .second]))
//                .font(.title2.bold())
//                .foregroundColor(Color.labelColor)
//                .contentTransition(.numericText())
//        }
    }
}
