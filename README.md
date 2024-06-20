# 2024-NC2-A41-Notification

## 🎥 Youtube Link

(to be continued)

<br>

## 💡 About Notification

<img width="700" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A41-Notification/assets/62278377/3a6ebee1-a318-4fab-99b4-c834f642f801">


> Push Notification 을 줄 수 있는 두 가지 방법

- local → foreground 일 때 알림 안 뜸
- APNS → local보다 훨씬 다양한 알림 사용 가능

<br>

### 제약사항

 - APNS - 개발자 계정 있어야 함 ! `필수 !`
> 

### Tip
<img width="700" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A41-Notification/assets/62278377/04552628-94d8-4f0b-bb17-c736061bddbf">



<br>
<br>

## 🎯 What we focus on?
<img width="700" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A41-Notification/assets/62278377/15c1b117-929e-4830-9126-11a05da5e782">


<br>
<br>


## 💼 Use Case
<img width="1042" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A41-Notification/assets/62278377/a9ed759c-479f-4ca7-be20-91e8a6cc221c">


<br>
<br>


## 🖼️ Prototype

<img width="1008" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A41-Notification/assets/62278377/ef2f45e8-6c58-4f48-baa9-3d8d7f61d5ef">

https://github.com/DeveloperAcademy-POSTECH/2024-NC2-A41-Notification/assets/62278377/966a1aba-6fde-4f8c-bd4e-a142937ce14f



<br>


## 🛠️ About Code

✅ 버튼 액션 작성 및 알림 센터 등록
✅ 적절한 컨텐츠를 채워넣은 알림을 사용자에게 전송하기
✅ 사용자에게 푸시 알림 권한 요청하기

---

- 프로젝트에 notification content extension 추가
- `알림 액션과 커스텀 카테고리를 설정`해서 알림 센터에 등록

---

<br>


```swift
import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        // MARK: - 푸시 알림 권한 요청
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification authorization error: \(error)")
            }
            print("Notification permission granted: \(granted)")
        }
        application.registerForRemoteNotifications() // 원격 알림 등록
        return true
        
        //MARK: - 커스텀 notification을 위한 부분
        // 알림 액션 설정
        let doneAction = UNNotificationAction(identifier: "doneAction", title: "Done", options: [.destructive])
        let openAction = UNNotificationAction(identifier: "openAction", title: "Open CooKoo", options: [.foreground])
        
        // 알림 카테고리 설정
        let customCategory = UNNotificationCategory(identifier: "customNotificationCategory",
                                                    actions: [openAction, doneAction],
                                                    intentIdentifiers: [],
                                                    options: [.customDismissAction])
        // 카테고리 등록
        center.setNotificationCategories([customCategory])
    }
}
```

<br>


## ✅ 버튼 액션 작성 및 알림 센터 등록

---

```swift
// 앱이 foreground에 있을 때 푸시 알림 호출
extension AppDelegate: UNUserNotificationCenterDelegate {

    // 알림 수신 시 호출되는 부분
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, 
withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge, .list])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, 
withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "doneAction" {
            // Done 액션 처리
            print("Done action triggered")
        } 
        else if response.actionIdentifier == "openAction" {
            // 앱 오픈 액션 처리
            print("Open action triggered")
        }
        completionHandler()
    }
}

```

<br>


## ✅ 적절한 컨텐츠를 채워넣은 알림을 사용자에게 전송하기

---

- **NotificationViewController**와 **MainInterface**에서 확장된 `알림의 UI`를 꾸밀 수 있음
- 알림을 보낼 때 `제목, 카테고리, 내용` 뿐만 아니라 함께 울릴 `사운드`까지 추가해서 요청을 생성하면 알림 센터에 커스텀된 알림을 추가할 수 있음

```swift
// MARK: - 커스텀 푸시 알림을 보내는 함수
    func sendNotification() {
        let content = UNMutableNotificationContent()
        
        // MARK: 알림 내용을 설정하는 부분
        content.title = "CooKoo"
        content.categoryIdentifier = "customNotificationCategory"
        
        // MARK: selectedKeyword에 따라 다른 문구 설정
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
        
        // MARK: 알림과 함께 울릴 사운드 전송
        content.sound = UNNotificationSound.defaultRingtone
        
        // 알림의 트리거 발송
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        // 요청 생성
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // MARK: 요청을 알림 센터에 추가
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            }
        }
        
        // MARK: 작동 중이던 Live activity 종료
        LiveActivityManager().endActivity()
    }
```
