//
//  TimerStartView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/16/24.
//

import SwiftUI
import Combine

struct TimerStartView: View {
    @State private var startTime = Date()
    @Binding var selectedKeyword: Keyword
    @Binding var totalTime: TimeInterval //고정 값 total duration
    @State var duration: TimeInterval
    @State var progress = 1.0
    @State var interval = TimeInterval()
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isTimerRunning = false
    
    var body: some View {
        VStack {
            Spacer()
            if isTimerRunning {
                CircleTimerView(progress: $progress, duration: $duration)
            }
            Spacer()
            
            HStack(spacing: 24) {
                Button(action: {
                    startTimer()
                }) {
                    Text("Start")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .disabled(isTimerRunning)
                
                Button(action: {
                    stopTimer()
                }) {
                    Text("Stop")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .disabled(!isTimerRunning)
            }
            .padding(.top, 20)
        }
        .onAppear {
            duration = totalTime
            startTimer()
        }
        .onReceive(timer) { time in
            if (isTimerRunning) {
                interval = Date().timeIntervalSince(startTime)
                duration = totalTime - interval
                progress = (duration / totalTime)

                // Stop timer when it finishes
                if duration <= 0 {
                    stopTimer()
                } else {
//                    guard let id = activity?.id else { return }
//                    LiveActivityManager().updateActivity(
//                        activity: id,
//                        duration: duration,
//                        progress: progress
//                    )
                }
            }
        }
    }
    
    func startTimer() {
        startTime = Date()
        isTimerRunning = true
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer.upstream.connect().cancel()
        resetTimer()
    }
    
    func resetTimer() {
        duration = totalTime
        progress = 1.0
    }
}
