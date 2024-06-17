//
//  TimerStartView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/16/24.
//

import SwiftUI
import Combine
import ActivityKit

struct TimerStartView: View {
    @Binding var selectedKeyword: Keyword
    @State var totalTime: TimeInterval
    @State var duration: TimeInterval = 0
    @State var timer: AnyCancellable?
    @State var progress: Double = 1.0
    @State var timeString: String = ""
    @State var timerCompleted: Bool = false
    
    var body: some View {
        VStack {
            Text("Starting timer for \(selectedKeyword)")
                .font(.largeTitle)
                .padding()
            
            Text(timeString)
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .padding()
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.08)
                    .foregroundColor(.black)
                    .frame(width: 200, height: 200)

                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(270.0))
                    .foregroundColor(Color.blue)
                    .frame(width: 200, height: 200)

                Text(duration.format(using: [.minute, .second]))
                    .font(.title2.bold())
                    .foregroundColor(Color.labelColor)
                    .contentTransition(.numericText())
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            timer?.cancel()
        }
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
            updateTimer()
        }
        _ = LiveActivityManager().startActivity(duration: duration, progress: progress)
    }
    
    private func updateTimer() {
        guard totalTime > 0 else {
            timer?.cancel()
            timer = nil
            return
        }
        
        totalTime -= 1
        timeString = formatTime(seconds: Int(totalTime))
        progress = totalTime / duration
    }
    
    private func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
