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
    }
    
    
    func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        
    }
}
