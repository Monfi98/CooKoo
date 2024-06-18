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
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error)")
            }
            print("Notification permission granted: \(granted)")
        }
        
        application.registerForRemoteNotifications() // 원격 알림 등록

        return true
    }
    
    // 원격 알림 등록 성공 시 호출
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }

    // 원격 알림 등록 실패 시 호출
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }
}

// UNUserNotificationCenterDelegate 확장
extension AppDelegate: UNUserNotificationCenterDelegate {
    // 앱이 포그라운드에 있을 때 푸시 알림을 수신했을 때 호출됩니다.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .badge, .banner])
    }
}




//import UIKit
//import UserNotifications
//
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        
//        // 1. 푸시 권한 요청
//        let center = UNUserNotificationCenter.current()
//        center.delegate = self
//        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
//            print(granted)
//        }
//        
//        // 2. device 토큰 획득: application(_:didRegisterForRemoteNotificationsWithDeviceToken:) 메소드 호출
//        application.registerForRemoteNotifications()
//        
//        return true
//    }
//    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
//        print(tokenString)
//    }
//
//    func applicationWillResignActive(_ application: UIApplication) {
//        print("AppDelegate: applicationWillResignActive")
//    }
//
//    func applicationDidEnterBackground(_ application: UIApplication) {
//        print("AppDelegate: applicationDidEnterBackground")
//    }
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//        print("AppDelegate: applicationWillEnterForeground")
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        print("AppDelegate: applicationDidBecomeActive")
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//        print("AppDelegate: applicationWillTerminate")
//    }
//}
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//    // foreground에서 시스템 푸시를 수신했을 때 해당 메소드가 호출
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.sound, .badge, .banner])
//    }
//}
