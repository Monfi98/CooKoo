//
//  NotificationViewController.swift
//  CooKooNotification
//
//  Created by Minjung Lee on 6/17/24.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        // Configure the view with the notification's content
        let content = notification.request.content
        
        // 예: 알림 내용을 레이블에 표시
        // myLabel.text = content.body
    }
}
