//
//  TimerStartView.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/16/24.
//

import SwiftUI
import Combine
import ActivityKit
import AVFoundation

struct TimerStartView: View {
    @Environment(\.presentationMode) var presentationMode
    
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
    @State var player: AVAudioPlayer?
    
    var body: some View {
        VStack {
            Divider()
                .foregroundColor(Color("CooKooBlack"))
                .padding(.bottom, 10)
            
            if(!isTimesUp){
                CircleTimerView(progress: $progress, duration: $duration, selectedKeyword: $selectedKeyword)
            } else {
                CooKooView()
                    .frame(maxHeight: 540)
            }
            Spacer()
            
            if(!isTimesUp){
                Button(action: {
                    if isTimerRunning {
                        stopTimer()
                    } else {
                        restartTimer()
                    }
                }) {
                    Text(isTimerRunning ? "Pause" : "Resume")
                        .font(.title2)
                        .frame(width: 350, height: 60)
                        .background(Color("AccentColor"))
                        .foregroundColor(Color("CooKooWhite"))
                        .cornerRadius(12)
                }
                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
                
            }
            
            else {
                HStack(spacing: 24) {
                    Button(action: {
                        timer.upstream.connect().cancel()
                        presentationMode.wrappedValue.dismiss()
                        LiveActivityManager().endActivity()
                    }) {
                        Text("Reset")
                            .font(.title2)
                            .frame(width: 148, height: 60)
                            .background(Color("AccentColor"))
                            .foregroundColor(Color("CooKooWhite"))
                            .cornerRadius(12)
                    }
                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
                    
                    Button(action: {
                        startTimer()
                        isTimesUp.toggle()
                    }) {
                        Text("Restart")
                            .font(.title2)
                            .frame(width: 148, height: 60)
                            .background(Color("AccentColor"))
                            .foregroundColor(Color("CooKooWhite"))
                            .cornerRadius(12)
                        
                    }
                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .background(Color.background)
        .onAppear {
            duration = totalTime
            startTimer()
            setupAudio()
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
                        playSound()
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
        LiveActivityManager().endActivity()
        startTime = Date()
        activity = LiveActivityManager().startActivity(duration: duration, progress: progress)
        isTimerRunning = true
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
    
    func restartTimer() {
        // 기존의 활동을 종료하고 새로운 활동을 시작
        LiveActivityManager().endActivity()
        
        startTime = Date() - (totalTime - duration)
        
        activity = LiveActivityManager().startActivity(duration: duration, progress: progress)
        
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        isTimerRunning = true
    }
    
    func setupAudio() {
        guard let soundURL = Bundle.main.url(forResource: "sound", withExtension: "wav") else {
            fatalError("Sound file not found")
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.prepareToPlay()
        } catch {
            print("Error loading sound file: \(error.localizedDescription)")
        }
    }
    
    func playSound() {
        player?.play()
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "CooKoo"
        // MARK: 커스텀 들어가는 부분
        content.categoryIdentifier = "customNotificationCategory"
        
        // selectedKeyword에 따라 다른 문구 설정
        switch selectedKeyword {
        case .cook:
            content.body = "Hey! Cooking's up!"
        case .study:
            content.body = "Hey! Studying's up!"
        case .exercise:
            content.body = "Hey! Workout's up!"
        case .laundry:
            content.body = "Hey! Laundry's up!"
        }
        
        content.sound = UNNotificationSound.defaultRingtone
        
        
        
        // 트리거: 0초 후에 알림 발송
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        // 요청 생성
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // 커스텀
        //        let request = UNNotificationRequest(identifier: "customNotificationCategory", content: content, trigger: trigger)
        
        // 요청을 알림 센터에 추가
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            }
        }
        LiveActivityManager().endActivity()
    }
}
