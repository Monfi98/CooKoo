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
        let doneAction = UNNotificationAction(identifier: "doneAction", title: "Done", options: [.foreground])
        let restartAction = UNNotificationAction(identifier: "restartAction", title: "Restart", options: [.foreground])
        
        // 알림 카테고리 설정
        let customCategory = UNNotificationCategory(identifier: "customNotificationCategory",
                                                    actions: [doneAction, restartAction],
                                                    intentIdentifiers: [],
                                                    options: [])
        
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
    
    
    // 알림 수신 시 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
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
    
    
    
    //    // 원격 알림 등록 성공 시 호출
    //    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    //        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
    //        let token = tokenParts.joined()
    //        print("Device Token: \(token)")
    //    }
    //
    //    // 원격 알림 등록 실패 시 호출
    //    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    //        print("Failed to register for remote notifications: \(error)")
    //    }
}

// 앱이 foreground에 있을 때 푸시 알림 호출
extension AppDelegate: UNUserNotificationCenterDelegate {
    //    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    //        completionHandler([.sound, .badge, .banner])
    //    }
}
