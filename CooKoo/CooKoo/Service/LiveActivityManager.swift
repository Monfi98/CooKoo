//
//  LiveActivityManager.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/17/24.
//

import ActivityKit
import Foundation

class LiveActivityManager {

    @discardableResult
    func startActivity(duration: TimeInterval, progress: Double) -> Activity<TimerAttributes>? {
        var activity: Activity<TimerAttributes>?
        let attributes = TimerAttributes(name: "CooKoo")

        do {
            let state = TimerAttributes.ContentState(
                duration: duration.format(using: [.hour, .minute, .second]),
                progress: progress
            )
            
            // ActivityContent 객체 생성
            let content = ActivityContent(state: state, staleDate: nil)
            
            activity = try Activity<TimerAttributes>.request(
                attributes: attributes,
                content: content,  // ActivityContent 객체를 전달
                pushType: nil
            )
        } catch {
            print(error.localizedDescription)
        }
        return activity
    }

    func updateActivity(activityID: String, duration: TimeInterval, progress: Double) {
        print("activity 시작")
        Task {
            let contentState = TimerAttributes.ContentState(
                duration: duration.format(using: [.minute, .second]),
                progress: progress
            )
            
            if let activity = Activity<TimerAttributes>.activities.first(where: { $0.id == activityID }) {
                await activity.update(using: contentState)
                print(activityID)
            }
        }
    }

    func endActivity() {
        print("activity 끝")
        Task {
            for activity in Activity<TimerAttributes>.activities {
                await activity.end(dismissalPolicy: .immediate)
                print(activity.id)
            }
        }
    }
}
