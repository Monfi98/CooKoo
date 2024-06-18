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
    @State private var startTime = Date()
    @Binding var selectedKeyword: Keyword
    @Binding var totalTime: TimeInterval //고정 값 total duration
    @State var duration: TimeInterval
    @State var progress = 1.0
    @State var interval = TimeInterval()
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isTimerRunning = false
    
    @State private var isTimesUp = false
    
    @State var activity: Activity<TimerAttributes>?
    
    var body: some View {
        VStack {
            Spacer()
            if(!isTimesUp){
                CircleTimerView(progress: $progress, duration: $duration, selectedKeyword: $selectedKeyword)
            } else {
                CooKooView()
            }
            Spacer()
            
            HStack(spacing: 24) {
                Button(action: {
                    startTimer()
                }) {
                    if(!isTimesUp){
                        Text("Start")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                }
                //.disabled(isTimerRunning)
                
                Button(action: {
                    stopTimer()
                }) {
                    if(!isTimesUp){
                        Text("Stop")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }

                }
                //.disabled(!isTimerRunning)
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

                if duration <= 0 {
                    resetTimer()
                    
                    isTimesUp = true
                } else {
                    guard let id = activity?.id else { return }
                    LiveActivityManager().updateActivity(
                        activityID: id,
                        duration: duration,
                        progress: progress
                    )
                }
            }
        }
    }
    
    func startTimer() {
        startTime = Date()
        activity = LiveActivityManager().startActivity(duration: duration, progress: progress)
        isTimerRunning.toggle()
        duration = totalTime
        resetTimer()
    }
    
    func stopTimer() {
        isTimerRunning.toggle()
        timer.upstream.connect().cancel()
        LiveActivityManager().endActivity()
    }
    
    func resetTimer() {
        duration = totalTime
        progress = 1.0
    }
}
