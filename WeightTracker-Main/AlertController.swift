//
//  AlertController.swift
//  SavingMoneyPlanning
//
//  Created by Phan Nhat Dang on 8/29/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import UIKit

class AlertController {
    static func showAlert(inController:UIViewController, tilte:String, message:String) {
        let alert = UIAlertController(title: tilte, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inController.present(alert, animated: true, completion: nil)
    }
    
    static func NotificationIsOff(in vc:UIViewController) {
        let alert = UIAlertController(title: "Notifications is off", message: "You have not enabled Notifications on this application. Go to Settings to turn on Notifications to be notified when events.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(ok)
        vc.present(alert,animated: true )
    }
}

