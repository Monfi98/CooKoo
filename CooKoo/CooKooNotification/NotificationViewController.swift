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
    
    @IBOutlet var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor(named: "AccentColor")
    }
    
    func didReceive(_ notification: UNNotification) {
        // Configure the view with the notification's content
        let content = notification.request.content
        
        // 예: 알림 내용을 레이블에 표시
         //myLabel.text = content.body
    }
}
