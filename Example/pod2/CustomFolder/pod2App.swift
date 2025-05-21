//
//  iosPodApp.swift
//  iosPod
//
//  Created by sushil on 5/1/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications
import FirebaseAnalytics
import FirebaseCrashlytics
import UIKit


// for user-selected actions from notification and foreground
//method to identify the selected action and provide an appropriate response.

//Asks the delegate to process the user’s response to a delivered notification.


class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject, MessagingDelegate {
    
    //Initialization
    var app: pod2App?
    
    //called when app is launched
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Debug application1 called")
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        // app to ask USEr permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {  (success, error) in
              if success {
                // `UNUserNotificationCenter` returns from a background thread
                  UNUserNotificationCenter.current().delegate = self
                  print("Debug UNUserNotification Permission Granted")
                DispatchQueue.main.async {
                  // Register to get `deviceToken`
                    print("Debug: Dispatch")
                   // Enable for router functionality: AppState.shared.pageToNavigateTo = "SS"
                  UIApplication.shared.registerForRemoteNotifications()
                }
              } else if let error = error {
                  print("Debug UNUserNotification Permission NOT Granted")
                  print(error)
                  Crashlytics.crashlytics().log("didFinishLaunchingWithOptions | UNUserNotification Permission NOT Granted \(error) ")
              }
            }
        
       // changing the order UIApplication.shared.registerForRemoteNotifications()
      
        Messaging.messaging().delegate = self
        
        application.registerForRemoteNotifications()
        // sends a request to APN to obtain device token. Results are in
        //application(_:didRegisterForRemoteNotificationsWithDeviceToken:)
        // or application(_:didFailToRegisterForRemoteNotificationsWithError:)
        return true
    }
    
    
    //registration callback1
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        
        print("Debug: application method2 called")
      //swizzling disabled : mapping your APNs token and registration token
        //With the Firebase Unity SDK on iOS, do not disable method swizzling. Swizzling is required by the SDK, and without it key Firebase features such as FCM token handling do not function properly.
      //  a link between the APNs token and the FCM library
        //device token is linked to FCM token
        print("hello22")
        print("Debug: Messaging.messaging().apnsToken")
        print(Messaging.messaging().apnsToken)
        print("Debug: devicetoken")
        print(deviceToken.base64EncodedString())
        let tokenComponents = deviceToken.map {data in String(format: "%02.2hhx", data)}
        let deviceTokenString = tokenComponents.joined()
        print("Debug: deviceTokenString Hexa")
        print(deviceTokenString)
        
        
        Messaging.messaging().apnsToken = deviceToken
        
    }
    
    // registration callback when failed. Token is not available
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){
    print("Debug: fail to register")
    print("Remote notification is unavailable: \(error.localizedDescription)")
        Crashlytics.crashlytics().log("beneprotoApp | pushNotification failed to register \(error.localizedDescription)")
}
   
    // application IN-POINT when remote notification is received.
    //AppDelegate: to identify the selected action and provide an appropriate response.
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Debug application-remote-notification")
        print("DDEBUG3")
        switch UIApplication.shared.applicationState {
        case .active:
            // app-in-foreground
            print("Received push message from APNs on Foreground")
            /*
            print("Debug userInfo perform action \(userInfo)")
            print("Debug userInfo userInfo[aps] \(String(describing: userInfo["aps"]))")
            if let aps = userInfo["aps"] as? [String : AnyObject],
                       let alertDict = aps["alert"] as? String {
                        print("Body :", alertDict)
                    }
            */
            NotificationCenter.default.post(name: Notification.Name("didReceiveRemoteNotification"), object: nil,
                                            userInfo: userInfo)
        case .background:
            print("Received push message from APNs on Background")
        case .inactive:
            print("Received push message from APNs back to Foreground")
            
            NotificationCenter.default.post(name: Notification.Name("didReceiveRemoteNotification"), object: nil,
                                            userInfo: userInfo)
           

            /*
            guard let nav = window?.rootViewController as? UINavigationController,
                  let currentVC = nav.viewControllers.last else {return}

            if currentVC is 'youWantViewController' { //if you want ViewController, use notification post
                let name = Notification.Name(rawValue: K.Event.pushRequest)
                NotificationCenter.default.post(name: name, object: nil)
            } else { //move to you want ViewController
               let vc = 'yourViewController'()
               root.navigationController?.pushViewController(vc, animated: true)
            }
            */
        }
        print("DDEBUG4")
        completionHandler(.newData)
    }
   
    
    //FCM token as a unique id for the app instance. For PUSH notification
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?){
        print("Debug: messaging method called, FCM registration")
        if let fcm = Messaging.messaging().fcmToken {
            print("fcm", fcm)
            UserDefaults.standard.set(fcm, forKey: "requestMobileId")
          
        }
        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("second FCM registration token: \(token)")
              UserDefaults.standard.set(fcmToken, forKey: "fcmtoken")
              UserDefaults.standard.set(UIDevice.current.identifierForVendor!.uuidString, forKey: "DeviceId")
          
          }
        }
    }
    /*
     works
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?){
        print("Debug: messaging method called, FCM registration")
        if let fcm = Messaging.messaging().fcmToken {
            print("fcm", fcm)
        }
        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("second FCM registration token: \(token)")
          
          }
        }
    }
    */
    

    func registerForPushNotifications(application: UIApplication) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound], completionHandler: { (granted, error) in
            print("DDEBUG5")
            DispatchQueue.main.async {
                if granted {
                    // Register after we get the permissions.
                    UNUserNotificationCenter.current().delegate = self
                }
            }
         
        })
    }
  /*
   old
   func registerPushNotifications(application: UIApplication) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                guard granted else { return }
                // If the user allows showing notification, then register the device to receive a push notification
                UNUserNotificationCenter.current().delegate = self
                self.registerForRemoteNotification()
        }
    }
    */
    func registerForRemoteNotification() {
        print("Debug called registerForRemoteNotification")
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }

            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    private func setupRemoteNotification() {
        print("Debug setupRemoteNotification point")
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { authenticated, error in
            if let error {
                print("xx-->> Error: \(error.localizedDescription)")
            }
            
            guard authenticated else {
                return
            }
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    
   
    
   
    
    fileprivate func showLocalNotification() {

            //creating the notification content
            let content = UNMutableNotificationContent()
print("Debug showLocalNotification")
            //adding title, subtitle, body and badge
            content.title = "App Update"
            //content.subtitle = "local notification"
            content.body = "New version of app update is available."
            content.badge = 1
           // content.sound = UNNotificationSound.default()

            //getting the notification trigger
            //it will be called after 5 seconds
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

            //getting the notification request
            let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)

            //adding the notification to notification center
        print("DDEBUG6")
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    
}
extension AppDelegate: UNUserNotificationCenterDelegate{
    
    //For background app state. perform an action when USER tap on the notification, asynchronus, works
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
      // control comes here when app in background mode and message is tapped
        let userInfo = response.notification.request.content.userInfo
        print("Sean: background Notification userInfo: \(userInfo)")
       
        if let requestId = userInfo["requestId"] as? String
        {
            UserDefaults.standard.set(requestId, forKey: "requestId") // Store in UserDefaults
            print("Debug0:background push, requestId=\(requestId)")
        }
        
        
        if let chatThreadId = userInfo["chatThreadId"] as? String
        {
            UserDefaults.standard.set(chatThreadId, forKey: "chatThreadId") // Store in UserDefaults
        }
        if let roomId = userInfo["roomId"] as? String
        {
            UserDefaults.standard.set(roomId, forKey: "roomId") // Store in UserDefaults
        }
     
        
        // extract BENE parameters for CHAT:
        if let chat_user_identity = userInfo["chat_user_identity"] as? String
        {
            UserDefaults.standard.set(chat_user_identity, forKey: "chat_user_identity") // Store in UserDefaults
        }
        if let chat_user_token = userInfo["chat_user_token"] as? String
        {
            UserDefaults.standard.set(chat_user_token, forKey: "chat_user_token") // Store in UserDefaults
        }
        
        // extract BENE parameters for VIDEO:
        // not needed
        /*
        if let video_user_identity = userInfo["video_user_identity"] as? String
        {
            UserDefaults.standard.set(video_user_identity, forKey: "video_user_identity") // Store in UserDefaults
        }
        if let video_user_token = userInfo["video_user_token"] as? String
        {
            UserDefaults.standard.set(video_user_token, forKey: "video_user_token") // Store in UserDefaults
        }
        */
        // extract CSR parameters for CHAT/VIDEO:
        if let chat_csr_token = userInfo["chat_csr_token"] as? String
        {
            UserDefaults.standard.set(chat_csr_token, forKey: "chat_csr_token") // Store in UserDefaults
        }
       
        if let chat_csr_identity = userInfo["chat_csr_identity"] as? String
        {
            UserDefaults.standard.set(chat_csr_identity, forKey: "chat_csr_identity") // Store in UserDefaults
        }
        
        //extract deep link parameter
        if let deepLink = response.notification.request.content.userInfo["link"] as? String, let url = URL(string: deepLink) {
       
           //is it needed here ? can NotificationManagerMain is used instead
            //NotificationManager.shared.notificationUserInfo = response.notification.request.content.userInfo
            print("Debug: Background1 received Deep Link \(deepLink)")
            
           
            
            // Enable for deep link
            Task {
                await app?.handlingOfDeepLinks(from: url)
            }
             
        }
        print("DDEBUG6")
        NotificationCenter.default.post(name: Notification.Name("didReceiveRemoteNotification"), object: nil,
                                        userInfo: userInfo)
    //    print("DDEBUG2b")
    //    completionHandler([.banner, .list, .sound, .badge]) // Customize presentation options
     
    }
    
    private func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)  {
      // control comes here when app in background mode and message is tapped
        print("Debug: Background call")
        let userInfo = response.notification.request.content.userInfo
        print("Sean: background2 Notification userInfo: \(userInfo)")
        
        if let requestId = userInfo["requestId"] as? String
        {
            UserDefaults.standard.set(requestId, forKey: "requestId") // Store in UserDefaults
            print("Debug0:background push, requestId=\(requestId)")
        }
        
        if let chatThreadId = userInfo["chatThreadId"] as? String
        {
            UserDefaults.standard.set(chatThreadId, forKey: "chatThreadId") // Store in UserDefaults
        }
        if let roomId = userInfo["roomId"] as? String
        {
            UserDefaults.standard.set(roomId, forKey: "roomId") // Store in UserDefaults
        }
      
        
        // extract BENE parameters for CHAT:
        if let chat_user_identity = userInfo["chat_user_identity"] as? String
        {
            UserDefaults.standard.set(chat_user_identity, forKey: "chat_user_identity") // Store in UserDefaults
        }
        if let chat_user_token = userInfo["chat_user_token"] as? String
        {
            UserDefaults.standard.set(chat_user_token, forKey: "chat_user_token") // Store in UserDefaults
        }
        
        // extract BENE parameters for VIDEO:
        /* not needed
        if let video_user_identity = userInfo["video_user_identity"] as? String
        {
            UserDefaults.standard.set(video_user_identity, forKey: "video_user_identity") // Store in UserDefaults
        }
        if let video_user_token = userInfo["video_user_token"] as? String
        {
            UserDefaults.standard.set(video_user_token, forKey: "video_user_token") // Store in UserDefaults
        }
        */
        
        // extract CSR parameters for CHAT/VIDEO:
        if let chat_csr_token = userInfo["chat_csr_token"] as? String
        {
            UserDefaults.standard.set(chat_csr_token, forKey: "chat_csr_token") // Store in UserDefaults
        }
       
        if let chat_csr_identity = userInfo["chat_csr_identity"] as? String
        {
            UserDefaults.standard.set(chat_csr_identity, forKey: "chat_csr_identity") // Store in UserDefaults
        }
        
        if let deepLink = userInfo["link"] as? String, let url = URL(string: deepLink) {
            
            print("Debug: Background received Deep Link \(deepLink)")
            
         
            /* Enable  for deeplink
            Task {
                await app?.handlingOfDeepLinks(from: url)
            }
             */
        }
        
        //extract deep link parameter
        if let deepLink = response.notification.request.content.userInfo["link"] as? String, let url = URL(string: deepLink) {
        // original. Is it needed now? Can NotificationManagerMain be used
            //NotificationManager.shared.notificationUserInfo = response.notification.request.content.userInfo
            print("Debug: Background2 received Deep Link \(deepLink)")
            
            Task {
                await app?.handlingOfDeepLinks(from: url)
            }
             
        }
        if #available(iOS 16.0, *) {
            UNUserNotificationCenter.current().setBadgeCount(0)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        NotificationCenter.default.post(name: Notification.Name("didReceiveRemoteNotification"), object: nil,
                                        userInfo: userInfo)
       // completionHandler() // Play alert and sound
        completionHandler([.banner, .list, .sound,.badge]) // Customize presentation options
        print("DDEBUG7")
     
    }
   
    
    /*
     //perform an action when USER tap on the notification, synchronus
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
        print("Debug: USER NotificationCenter Did Receive")
        let userInfo = response.notification.request.content.userInfo
        //  print("Debug userInfo perform action \(userInfo)")
        if #available(iOS 16.0, *) {
            UNUserNotificationCenter.current().setBadgeCount(0)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        NotificationCenter.default.post(name: Notification.Name("didReceiveRemoteNotification"), object: nil,
                                        userInfo: userInfo)
        
        /*
         // Get the meeting ID from the original notification.
         let userInfo = response.notification.request.content.userInfo
         let meetingID = userInfo["MEETING_ID"] as! String
         let userID = userInfo["USER_ID"] as! String
         
         // Perform the task associated with the action.
         switch response.actionIdentifier {
         case "ACCEPT_ACTION":
         sharedMeetingManager.acceptMeeting(user: userID,
         meetingID: meetingID)
         break
         
         case "DECLINE_ACTION":
         sharedMeetingManager.declineMeeting(user: userID,
         meetingID: meetingID)
         break
         
         // Handle other actions...
         default:
         break
         }
         */
        
        //always call this one in the end, when done
        completionHandler()
    }
*/
    // Handle notifications while in foreground.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle received notification here
        
        print("Debug: Will present Handle received notification here")
      // test  FirebaseHome().handleFirebaseNotification(userInfo: notification.request.content.userInfo)
        let userInfo = notification.request.content.userInfo
        print("Sean: foreground1 Notification userInfo: \(userInfo)")
        if let soundName = userInfo["sound"] as? String
        {
            UserDefaults.standard.set(soundName, forKey: "soundName") // Store in UserDefaults
            print("Playing ringtone: \(soundName)")
        }
        if let roomId = userInfo["roomId"] as? String
        {
            UserDefaults.standard.set(roomId, forKey: "roomId") // Store in UserDefaults
        }
        // extract BENE parameters for CHAT:
        if let chat_user_identity = userInfo["chat_user_identity"] as? String
        {
            UserDefaults.standard.set(chat_user_identity, forKey: "chat_user_identity") // Store in UserDefaults
        }
        if let chat_user_token = userInfo["chat_user_token"] as? String
        {
            UserDefaults.standard.set(chat_user_token, forKey: "chat_user_token") // Store in UserDefaults
        }
        
        // extract BENE parameters for VIDEO:
        if let video_user_identity = userInfo["video_user_identity"] as? String
        {
            UserDefaults.standard.set(video_user_identity, forKey: "video_user_identity") // Store in UserDefaults
        }
        if let video_user_token = userInfo["video_user_token"] as? String
        {
            UserDefaults.standard.set(video_user_token, forKey: "video_user_token") // Store in UserDefaults
        }
        
        // extract CSR parameters for CHAT/VIDEO:
        if let chat_csr_token = userInfo["chat_csr_token"] as? String
        {
            UserDefaults.standard.set(chat_csr_token, forKey: "chat_csr_token") // Store in UserDefaults
        }
       
        if let chat_csr_identity = userInfo["chat_csr_identity"] as? String
        {
            UserDefaults.standard.set(chat_csr_identity, forKey: "chat_csr_identity") // Store in UserDefaults
        }
        
        if let deepLink = userInfo["link"] as? String, let url = URL(string: deepLink) {
            
            print("Debug: Foreground, received Deep Link \(deepLink)")
            
            // Enable  for deeplink
            Task {
                await app?.handlingOfDeepLinks(from: url)
            }
            print("Debug: Foreground deeplink")
        }
      //  print("Debug userInfo perform action \(userInfo)")
        if #available(iOS 16.0, *) {
            UNUserNotificationCenter.current().setBadgeCount(0)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        NotificationCenter.default.post(name: Notification.Name("didReceiveRemoteNotification"), object: nil,
                                        userInfo: userInfo)
        print("DDEBUG2b")
        completionHandler([.banner, .list, .sound, .badge]) // Customize presentation options
        
        /*
        if notification.request.content.categoryIdentifier ==
                    "MEETING_INVITATION" {
              // Retrieve the meeting details.
              let meetingID = notification.request.content.
                               userInfo["MEETING_ID"] as! String
              let userID = notification.request.content.
                               userInfo["USER_ID"] as! String
                    
              // Add the meeting to the queue.
              sharedMeetingManager.queueMeetingForDelivery(user: userID,
                    meetingID: meetingID)


              // Play a sound to let the user know about the invitation.
              completionHandler(.sound)
              return
           }
           else {
              // Handle other notification types...
           }
         // Don't alert the user for other types.
            completionHandler(UNNotificationPresentationOptions(rawValue: 0))
        */
        
        
    }
    
}
// Todo: handle PUSH notification when app is in the foreground

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var pageToNavigateTo : String?
}


@main
struct pod2App: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @StateObject private var routerManager = NavigationRouter()
    @State private var openedFromURL: URL?
    
    var body: some Scene {
        WindowGroup {
            
            let userSettings = UserSettings()
            
            // testcase: ContentView()
            MainContentViewWithRoutes() // withoutroutes
                .environmentObject(routerManager)
                .environmentObject(NotificationManagerMain.shared)
                .environmentObject(userSettings)
                .preferredColorScheme(.light)
                .onOpenURL { url in
                    print("Debug Main entry point:  \(url)")
                 
                    
                }
                .onAppear {
                    appDelegate.app = self
                }
        }
    }
    
    init(){
        print("pod1 app initialized")
    }
}


private extension pod2App {
    func handlingOfDeepLinks( from url: URL) async {
        let routeFinder = RouteFinder()
        if let route = await routeFinder.find(from: url){
            routerManager.push(to: route)
        }
    }
}
