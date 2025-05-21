//
//  NotificationManager.swift
//  bene
//
//  Created by sushil on 12/18/24.
//

import Foundation
import UserNotifications

@MainActor
class NotificationManagerMain: ObservableObject {
    @Published private(set) var hasPermission = false
    @Published var notificationUserInfo: [AnyHashable: Any]? = nil
    static let shared = NotificationManagerMain()
    
    init(){
        Task{
            await getAuthStatus()
        }
    }
    
    func printMessage() async {
        do {
            
            UNUserNotificationCenter.current().getDeliveredNotifications{
                (notifications) in
                print(notifications)
                print("Debug:PrintMessage: \(notifications)")
            }
        }
        catch{
            print(error)
        }
    }
    func request() async {
        do {
            self.hasPermission =  try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            await getAuthStatus()
          
        }
        catch{
            print(error)
        }
    }
    
    func getAuthStatus() async {
        let status =  await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
        case .authorized, .ephemeral, .provisional:
            print("Debug:Success NotificationManager:getAuthStatus:status.authorization status= \(status.authorizationStatus)")
            hasPermission = true
        default:
            hasPermission = false
            print("Debug: default case: NotificationManager:getAuthStatus:status.authorization status= \(status.authorizationStatus)")
        }
    }
}
