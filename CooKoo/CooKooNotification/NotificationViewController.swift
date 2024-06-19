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
    

    @IBOutlet weak var myLabel: UILabel!
    //@IBOutlet weak var CooKooImageView: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor(named: "AccentColor")
    }
    
    
    func didReceive(_ notification: UNNotification) {
        // Configure the view with the notification's content
        let content = notification.request.content

        // 예: 알림 내용을 레이블에 표시
         myLabel.text = content.body
//        imageView = UIImageView(image: "cookoo")
        //imageView = UIImage(named: "cookoo")
//        if let imageName = content.userInfo["image"] as? String,
//           let image = UIImage(named: imageName) {
//            CooKooImageView.image = image
//        }
        
    }
}
