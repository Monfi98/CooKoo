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

// for Lottie 
import Lottie
import UIKit

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
                .padding(.bottom,10)

            if(!isTimesUp){
                CircleTimerView(progress: $progress, duration: $duration, selectedKeyword: $selectedKeyword)
            } else {
                CooKooView()
            }
            Spacer()

            if(!isTimesUp){
                HStack(spacing: 24) {
                    Button(action: {
                        timer.upstream.connect().cancel()
                        presentationMode.wrappedValue.dismiss()
                        LiveActivityManager().endActivity()
                    }) {
                            Text("Back")
                                .font(.title2)
                                .frame(width: 148, height: 60)
                                .background(Color("AccentColor"))
                                .foregroundColor(Color("CooKooWhite"))
                                .cornerRadius(12)

                    }
                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
                    Button(action: {
                        if isTimerRunning {
                            stopTimer()
                        } else {
                            // TODO: - 여기 동작 이상함
                            //restartTimer()
                        }
                    }) {
                            Text(isTimerRunning ? "Stop" : "Restart")
                                .font(.title2)
                                .frame(width: 148, height: 60)
                                .background(Color("AccentColor"))
                                .foregroundColor(Color("CooKooWhite"))
                                .cornerRadius(12)
                    }
                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
                    
                }
            }

            else {
                Button(action: {
                    // TODO: - 방금 돌렸던 시간 다시 타이머 시작하도록 구현해야함
                    startTimer()
                }) {
                    Text("Start Again")
                        .font(.title2)
                        .frame(width: 350, height: 60)
                        .background(Color("AccentColor"))
                        .foregroundColor(Color("CooKooWhite"))
                        .cornerRadius(12)
                }
                .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 2)
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
        //LiveActivityManager().endActivity()
    }

//    func restartTimer() {
//        activity = LiveActivityManager().startActivity(duration: duration, progress: progress)
//        isTimerRunning = true
//    }
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
        LiveActivityManager().endActivity()
    }
}
