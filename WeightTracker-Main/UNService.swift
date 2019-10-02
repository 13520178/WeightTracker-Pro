//
//  UNService.swift
//  WeightTracker-Main
//
//  Created by Phan Nhat Dang on 9/30/19.
//  Copyright © 2019 Phan Nhat Dang. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class UNService:NSObject {
    private override init() {}
    
    static let shared = UNService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error ?? "No Un auth error")
            guard granted else {
                print("USER DENIED ACCESS")
                return
            }
            self.configure()
        }
    }
    
    func configure() {
        unCenter.delegate = self
    }
    
    
    
    func timerRequest(with components: DateComponents) {
        //Remove if have first
        removeRequest()
        
        self.configure()
        let content = UNMutableNotificationContent()
        content.title = "Enter daily weight"
        content.body = "Be brave, don't be afraid of the scales anymore."
        content.sound = UNNotificationSound.default
        
        var com = DateComponents()
        com.hour = components.hour
        com.minute = components.minute
        com.second = 0
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: com, repeats: true)
        let request = UNNotificationRequest(identifier: "Alarm", content: content, trigger: trigger)
        
        unCenter.add(request)
    }
    
    func removeRequest() {
        unCenter.removePendingNotificationRequests(withIdentifiers: ["Alarm"])
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did revice response")
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Oh, will present a notification, let's see the identifier: \(notification.request.identifier)")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}
