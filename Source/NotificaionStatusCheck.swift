//
//  NotificaionStatusCheck.swift
//  
//
//  Created by sushil on 5/21/25.
//

//
//  NotificationStatusCheck.swift
//  beneproto
//
//  Created by sushil on 2/26/25.
//

import Foundation
import SwiftUI
import UserNotifications
import UIKit
import AVFoundation

class NotificationStatusCheck {
    
    
    var window: UIWindow?
    
    private var currentViewController : UIViewController? = nil
    
    
     static let shared = NotificationStatusCheck()
    
    public func currentViewController(_ vc: UIViewController?) {
        self.currentViewController = vc
        checkNotificationsAuthorizationStatus()
        checkAudioAuthorizationStatus()
        checkCameraAuthorizationStatus()
        
    }
    
    private func checkCameraPermission() -> AVAuthorizationStatus{
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    private func checkAudioPermission() ->  AVAuthorizationStatus{
        return AVCaptureDevice.authorizationStatus(for: .audio)
    }

    
    private func checkAudioAuthorizationStatus(){
        let audioPermissionStatus = checkAudioPermission()
        DispatchQueue.main.async{
            switch audioPermissionStatus {
            case .authorized:
                print("AUDIO access is granted")
            case .denied, .restricted:
                print("AUDIO access is denied/ restricted")
                self.AudioPopup()
            case .notDetermined:
                print("AUDIO access is not determined")
                self.AudioPopup()
            @unknown default:
                print("Default:Audio access is not determined")
                self.AudioPopup()
                
            }
        }
        
    }
    
    private func AudioPopup(){
        let AudioAlertController = UIAlertController(title: "Audio Alert", message: "Please Turn on the Audio for Audio call with CSR", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        AudioAlertController.addAction(cancelAction)
        AudioAlertController.addAction(settingsAction)
        DispatchQueue.main.async {
            self.currentViewController?.present(AudioAlertController, animated: true, completion: nil)
            
        }
    }

    
    private func checkCameraAuthorizationStatus(){
        let cameraPermissionStatus = checkCameraPermission()
        
        DispatchQueue.main.async{
            switch cameraPermissionStatus {
            case .authorized:
                print("CAMERA access is granted")
            case .denied, .restricted:
                print("CAMERA access is denied/ restricted")
                self.CameraPopup()
            case .notDetermined:
                print("CAMERA access is not determined")
                self.CameraPopup()
            @unknown default:
                print("Default: CAMERA access is not determined")
                self.CameraPopup()
                
            }
        }
       
    }
    
    private func CameraPopup(){
        let CameraAlertController = UIAlertController(title: "CAMERA Alert", message: "Please Turn on the CAMERA for VIDEO call with CSR", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        CameraAlertController.addAction(cancelAction)
        CameraAlertController.addAction(settingsAction)
        DispatchQueue.main.async {
            self.currentViewController?.present(CameraAlertController, animated: true, completion: nil)
            
        }
    }
    
    private func checkNotificationsAuthorizationStatus() {
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.getNotificationSettings { (notificationSettings) in
            DispatchQueue.main.async{
                switch notificationSettings.authorizationStatus {
                case .authorized:
                    print("The app is authorized to schedule or receive notifications.")
                    
                case .denied:
                    print("The app isn't authorized to schedule or receive notifications.")
                    self.NotificationPopup()
                case .notDetermined:
                    print("The user hasn't yet made a choice about whether the app is allowed to schedule notifications.")
                    self.NotificationPopup()
                case .provisional:
                    print("The application is provisionally authorized to post noninterruptive user notifications.")
                    self.NotificationPopup()
                case .ephemeral:
                    //new case
                    print("The application is provisionally authorized to post noninterruptive user notifications.")
                    self.NotificationPopup()
                @unknown default:
                    //new case
                    print("The app isn't authorized to schedule or receive notifications.")
                    self.NotificationPopup()
                }
            }
           
        }
        
    }
    
    private func NotificationPopup(){
        let alertController = UIAlertController(title: "Notification Alert", message: "Please Turn on the Notification to get update every time the Show Starts", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        DispatchQueue.main.async {
            self.currentViewController?.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
}

