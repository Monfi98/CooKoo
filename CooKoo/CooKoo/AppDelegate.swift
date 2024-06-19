//
//  AppDelegate.swift
//  CooKoo
//
//  Created by Minjung Lee on 6/18/24.
//

import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 푸시 알림 권한 요청
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        
        //MARK: - 커스텀 notification을 위한 부분
        // 알림 액션 설정
        let doneAction = UNNotificationAction(identifier: "doneAction", title: "Done", options: [.destructive]) // 빨간색으로 뜸 + 알림 사라짐
        let restartAction = UNNotificationAction(identifier: "restartAction", title: "Restart", options: [.foreground])
        
        // 알림 카테고리 설정
        let customCategory = UNNotificationCategory(identifier: "customNotificationCategory",
                                                    actions: [restartAction, doneAction],
                                                    intentIdentifiers: [],
                                                    options: [.customDismissAction])
        
        // 카테고리 등록
        center.setNotificationCategories([customCategory])
        
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error)")
            }
            print("Notification permission granted: \(granted)")
        }
        
        application.registerForRemoteNotifications() // 원격 알림 등록
        
        return true
    }
    
    

}

// 앱이 foreground에 있을 때 푸시 알림 호출
extension AppDelegate: UNUserNotificationCenterDelegate {
    // 알림 수신 시 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge, .list])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "doneAction" {
            // Done 액션 처리
            print("Done action triggered")
        } else if response.actionIdentifier == "restartAction" {
            // Restart 액션 처리
            print("Restart action triggered")
        }
        
        completionHandler()
    }
}
