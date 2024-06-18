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
                    if(!isTimesUp){
                        sendNotification()
                    }
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
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Coo-Koo!"
        
        // selectedKeyword에 따라 다른 문구 설정
        switch selectedKeyword {
        case .cook:
            content.body = "Great job staying focused on your work!"
        case .study:
            content.body = "Great job staying focused!"
        case .exercise:
            content.body = "Great job on your workout!"
        case .laundry:
            content.body = "Laundry is done!"
        }
        
        content.sound = UNNotificationSound.defaultRingtone
        
        // MARK: 커스텀 들어가는 부분
        content.categoryIdentifier = "customNotificationCategory"
        
        // 트리거: 0초 후에 알림 발송
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        // 요청 생성
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // 요청을 알림 센터에 추가
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            }
        }
    }
}
