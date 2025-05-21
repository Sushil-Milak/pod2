//
//  VFMPMainView.swift
//  beneproto
//
//  Created by sushil on 2/13/25.
//

import SwiftUI
import AzureCommunicationCalling
import AVFoundation
import UserNotifications

import FirebaseCore
import FirebaseAnalytics
import FirebaseCrashlytics

public struct VFMPMainViewR: View {
    let title: String
    @Environment(\.colorScheme) var colorScheme
    @State private var isFMPSessionLaunchView2Presented = false
    @State private var VFMPPath = NavigationPath()
    // is it needed? @EnvironmentObject private var routerManager: NavigationRouter
    
    
    @StateObject private var notificationManager = NotificationManager()
    
    @State private var token = ""
    @State private var acsUserId = ""
    @State private var roomId: String = ""
    @State private var deviceID:String = ""
    @State private var encounterRequestSent:Bool = false
    @State private var isAboutViewFocused: Bool = true
    @State private var isSampleViewFocused: Bool = false
    var acsHelper = ACSHelper()
    @StateObject private var userModel =  UserModel()
    
    @State private var isShowingViewForController = false
    @State var showModal = false
    /////
    @State private var cameraPermissionGranted = false
    @State private var showSettingsAlert = false
    @State private var microphonePermissionGranted = false
    @State private var microphoneshowSettingsAlert = false
    @State private var pushnotificationPermissionGranted = false
    @State private var pushnotificationshowSettingsAlert = false
    @State private var isencounterRequestExist: Bool = false
    @State private var isChatUserTokenExist: Bool = false
    
    public func checkPushNotificationPermission() {
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.getNotificationSettings { (notificationSettings) in
            DispatchQueue.main.async{
                switch notificationSettings.authorizationStatus {
                case .authorized:
                    print("The app is authorized to schedule or receive notifications.")
                    pushnotificationPermissionGranted = true
                    
                case .denied:
                    print("The app isn't authorized to schedule or receive notifications.")
                    pushnotificationPermissionGranted = false
                case .notDetermined:
                    print("The user hasn't yet made a choice about whether the app is allowed to schedule notifications.")
                    pushnotificationPermissionGranted = false
                case .provisional:
                    print("The application is provisionally authorized to post noninterruptive user notifications.")
                    pushnotificationPermissionGranted = false
                case .ephemeral:
                    //new case
                    print("The application is provisionally authorized to post noninterruptive user notifications.")
                    pushnotificationPermissionGranted = false
                @unknown default:
                    //new case
                    print("The app isn't authorized to schedule or receive notifications.")
                    pushnotificationPermissionGranted = false
                }
                if !pushnotificationPermissionGranted  {
                    pushnotificationshowSettingsAlert = true
                }
            }
            
        }
        
        
    }
    
    public  func checkMicroPhonePermission() {
        microphoneshowSettingsAlert = false
        AVCaptureDevice.requestAccess(for: .audio) { granted in
            DispatchQueue.main.async {
                microphonePermissionGranted = granted
                if !granted {
                    microphoneshowSettingsAlert = true
                }
            }
        }
    }
    
    public func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                cameraPermissionGranted = granted
                if !granted {
                    showSettingsAlert = true
                }
            }
        }
    }
        
    public init(title: String) {
            self.title = title
        }
        
        
    
    public  func openPushNotificationSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    public func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    public func openMicrophoneSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    private func checkStatus(){
        
        isencounterRequestExist = false
        isChatUserTokenExist = false
        if (UserDefaults.standard.string(forKey: "requestId") != nil )
        {
            isencounterRequestExist = true
        }
        
        if (UserDefaults.standard.string(forKey: "chat_user_token") != nil )
        {
            isChatUserTokenExist = true
        }
        
        
        
    }
    private func checkStatus() async {
        
        isencounterRequestExist = false
        isChatUserTokenExist = false
        
        
        do {
            try await acsHelper.GetEncounterRequestStatus()
            
        }
        catch {
            Crashlytics.crashlytics().log("VFMPMainViewR:checkstatus:ACSHELPER:encounterrequeststatus:error: ")
        }
        
        if(UserDefaults.standard.string(forKey: "GetEncounterRequestStatus") == "0" ){
            do {
                try await acsHelper.postNonPushNotificationMethod()
                try await checkStatusNonPush()
            }
            catch {
                Crashlytics.crashlytics().log("VFMPMainViewR:checkstatus:ACSHELPER:encounterrequeststatus:error: ")
            }
        }
        
        if (UserDefaults.standard.string(forKey: "requestId") != nil )
        {
            isencounterRequestExist = true
            let test1 = UserDefaults.standard.string(forKey: "requestId")
            print("Debug:requestId=\(test1)")
        }
        
        if (UserDefaults.standard.string(forKey: "chat_user_token") != nil )
        {
            isChatUserTokenExist = true
            let test2 = UserDefaults.standard.string(forKey: "chat_user_token")
            print("Debug:chat_user_token=\(test2)")
        }
        
    }
    private func checkStatusNonPush() async {
        
        isencounterRequestExist = false
        isChatUserTokenExist = false
        
        
        
        
        
        if (UserDefaults.standard.string(forKey: "requestId") != nil )
        {
            isencounterRequestExist = true
            let test1 = UserDefaults.standard.string(forKey: "requestId")
            print("Debug:requestId=\(test1)")
        }
        
        if (UserDefaults.standard.string(forKey: "chat_user_token") != nil )
        {
            isChatUserTokenExist = true
            let test2 = UserDefaults.standard.string(forKey: "chat_user_token")
            print("Debug:chat_user_token=\(test2)")
        }
        
    }
    private func CancelSessionRequest(){
        
        isencounterRequestExist = false
        isChatUserTokenExist = false
        
        if (UserDefaults.standard.string(forKey: "placeinqueue") != nil )
        {
            //TODO call
            //need to call {{BASE_URL_SERVICE_API}}/requests/b49919e6-f362-4c1b-ad71-9be9b5f04692
            UserDefaults.standard.removeObject(forKey: "placeinqueue")
        }
        
        if (UserDefaults.standard.string(forKey: "requestId") != nil )
        {
            //TODO call
            //need to call {{BASE_URL_SERVICE_API}}/requests/b49919e6-f362-4c1b-ad71-9be9b5f04692
            UserDefaults.standard.removeObject(forKey: "requestId")
        }
        if (UserDefaults.standard.string(forKey: "chatThreadId") != nil )
        {
            UserDefaults.standard.removeObject(forKey: "chatThreadId")
        }
        if (UserDefaults.standard.string(forKey: "roomId") != nil )
        {
            UserDefaults.standard.removeObject(forKey: "roomId")
        }
        
        if (UserDefaults.standard.string(forKey: "chat_user_identity") != nil )
        {
            UserDefaults.standard.removeObject(forKey: "chat_user_identity")
        }
        if (UserDefaults.standard.string(forKey: "chat_user_token") != nil )
        {
            UserDefaults.standard.removeObject(forKey: "chat_user_token")
        }
        if (UserDefaults.standard.string(forKey: "chat_csr_token") != nil )
        {
            UserDefaults.standard.removeObject(forKey: "chat_csr_token")
        }
        if (UserDefaults.standard.string(forKey: "chat_csr_identity") != nil )
        {
            UserDefaults.standard.removeObject(forKey: "chat_csr_identity")
        }
        if (UserDefaults.standard.string(forKey: "video_user_identity") != nil )
        {
            UserDefaults.standard.removeObject(forKey: "video_user_identity")
        }
        if (UserDefaults.standard.string(forKey: "video_user_token") != nil )
        {
            UserDefaults.standard.removeObject(forKey: "video_user_token")
        }
        if (UserDefaults.standard.string(forKey: "link") != nil )
        {
            UserDefaults.standard.removeObject(forKey: "link")
        }
        
        
        
    }
    public var body: some View {
        
        
        /*
         //MARK: Debug
         let _ = Self._printChanges()
        Text("VFMPMainViewR: What could possibly go wrong?")
        */
        GeometryReader { geometry in
            
            ZStack(alignment: .trailing) {
                VStack(alignment: .leading) {
                    if cameraPermissionGranted && microphonePermissionGranted &&  pushnotificationPermissionGranted {
                       
                        VStack {
                            VStack(alignment:.leading)
                            {
                                Text("FMP Main Page").font(.title).bold()
                                    .accessibilityHint(Text("FMP Main Page"))
                            }.padding()
                           
                        Button{
                            isFMPSessionLaunchView2Presented = true
                        }
                        label: {
                            VStack(alignment:.leading)
                            {
                                
                                Text("Create Session").font(.title2).bold()
                                    .accessibilityHint(Text("Button to Create Session Request"))
                            }
                        } //button decorators
                        .padding().background(isencounterRequestExist ? Color("Secondary_Light_Gray") : Color("Primary_Navy"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: 3)
                                ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                                //.buttonStyle(.bordered)
                    }.sheet(isPresented: $isFMPSessionLaunchView2Presented, onDismiss: {
                            Task{
                                await checkStatus()
                            }
                        }
                        ){
                            FMPSessionLaunchView2(isFMPSessionLaunchView2Presented: $isFMPSessionLaunchView2Presented)
                        }.disabled(isencounterRequestExist)
                       
                        /* Create Session works. Has separate Navigation. But we are going with SHEETS
                         //TODO: Show Start process on certain conditions
                        VStack(alignment: .leading) {
                            NavigationLink(destination: FMPSessionLaunchView(path: $VFMPPath)){
                                HStack{
                                    
                                    Text("Create Session")
                                        .font(.title2)
                                        .bold()
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 3)
                                        ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                        .padding(.all)
                                        .accessibilityHint(Text("Button to connect with a VFMP representative."))
                                    
                                    Spacer()
                                }
                                
                            }
                        }.padding(.bottom).disabled(isencounterRequestExist)
                        
                        */
                        
                        Divider()
                        //TODO: Show when session request created
                        VStack(alignment: .leading) {
                            if isencounterRequestExist{
                                Group {
                                    Divider()
                                    
                                    Text("Your are queue position is: \(UserDefaults.standard.string(forKey: "placeinqueue") ?? "unknown") ").bold().foregroundColor(Color.black).font(.headline).padding(.leading).padding(.bottom)
                                    Text("Your are requestid is:").bold().foregroundColor(Color.black).font(.headline).padding(.leading).padding(.bottom)
                                    Text("\(UserDefaults.standard.string(forKey: "requestId") ?? "Name not found") ").foregroundColor(Color.black).padding(.bottom)
                                    
                                    
                                    Text("Once CSR is available, you will received  a APP notification and JOIN CSR button will get activated ").bold().foregroundColor(Color.black).font(.headline).padding(.leading).padding(.bottom)
                                    
                                }
                            }
                            
                            Button(action: {
                                Task{
                                    do {
                                        //  navigate = true
                                        // activate when ICA service is ready: try await acsHelper.postCancel()
                                        try await acsHelper.postCancel()
                                        CancelSessionRequest()
                                    }
                                    catch{
                                        print("Error: \(error)")
                                        //Crashlytics and Analytics point
                                    }
                                }
                            }, label: {
                                VStack{
                                    Text("Cancel Session Request ")
                                        .font(.title2)
                                        .bold()
//                                        .cornerRadius(20)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 20)
//                                                .stroke(Color.gray, lineWidth: 3)
//                                        )
//                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                                        .padding(.bottom).padding(.top)
                                        .accessibilityHint(Text("Button to Cancel Session Request"))
                                }
                            }) //button decorators. need work to show disable view
                            .padding().background(!isencounterRequestExist ? Color("Secondary_Light_Gray") : Color("Primary_Navy"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white, lineWidth: 3)
                                    ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                                .disabled(!isencounterRequestExist)
                            //TODO: Show NON-PUSH Notification Method
                            
                            Divider()
                            Button(action: {
                                Task{
                                    do {
                                        //  navigate = true
                                        // activate when ICA service is ready: try await acsHelper.postCancel()
                                        try await acsHelper.postNonPushNotificationMethod()
                                        // CancelSessionRequest()
                                        try await checkStatusNonPush()
                                        
                                    }
                                    catch{
                                        print("Error: \(error)")
                                        //Crashlytics and Analytics point
                                    }
                                }
                            }, label: {
                                VStack{
                                    Text("Non PUSH-Notification ")
                                        .font(.title2)
                                        .bold()
//                                        .cornerRadius(20)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 20)
//                                                .stroke(Color.gray, lineWidth: 3)
//                                        ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                                        .padding(.bottom).padding(.top)
                                        .accessibilityHint(Text("Non PUSH-Notification Method to get ACS tokens"))
                                }
                            }).padding().background(!isencounterRequestExist ? Color("Secondary_Light_Gray") : Color("Primary_Navy"))
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: 3)
                                ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                                //.buttonStyle(.bordered)
                                .disabled(!isencounterRequestExist)
                            
                        }.disabled(!isencounterRequestExist)
                        
                        Divider()
                        
                    
                        //TODO show video button
                        VStack(alignment: .leading)  {
                            if(!(isencounterRequestExist && isChatUserTokenExist)){
                                //symbolic
                                Button(action: {
                                    Task{
                                        do {
                                            // do nothing
                                        }
                                        catch{
                                            print("Error: \(error)")
                                            //Crashlytics and Analytics point
                                        }
                                    }
                                }, label: {
                                    VStack{
                                        Text("Join CSR Call ")
                                            .font(.title2)
                                            .bold()
//                                            .cornerRadius(20)
//                                            .overlay(
//                                                RoundedRectangle(cornerRadius: 20)
//                                                    .stroke(Color.gray, lineWidth: 3)
//                                            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                                            .padding(.bottom).padding(.top)
                                            .accessibilityHint(Text("Button to Join CSR Call"))
                                    }
                                }).padding().background(!(isencounterRequestExist && isChatUserTokenExist) ? Color("Secondary_Light_Gray") : Color("Primary_Navy"))
                                    .foregroundColor(.red)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white, lineWidth: 3)
                                    ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                                    //.buttonStyle(.bordered)
                                    .disabled(!(isencounterRequestExist && isChatUserTokenExist))
                            }
                            else if((isencounterRequestExist && isChatUserTokenExist)){
                                VStack{
                                    
                                    NavigationView {
                                        ViewForController(path: $VFMPPath)//.navigationTitle("test1")
                                    }
                                    
                                }.disabled(!notificationManager.hasPermission).disabled(!(isencounterRequestExist && isChatUserTokenExist))
                            }
                            
                        }
                    }
                    else{
                        // missing USER Permissions
                        PermissionView()
                    }
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Ensures entire VStack is top-left
            .padding() // Optional: Add padding for visual clarity
            .onAppear{
                Task{
                    await checkStatus()
                }
            }.onAppear( perform: {
                Analytics.logEvent(AnalyticsEventScreenView,
                                   parameters: [AnalyticsParameterScreenName: "\(VFMPMainViewR.self)",
                                               AnalyticsParameterScreenClass: "\(VFMPMainViewR.self)"])
            }).onReceive(NotificationCenter.default.publisher(for: Notification.Name("didReceiveRemoteNotification"))){ notification in
                if let data = notification.object as? String {
                    //path.append(data)
                    
                    print("DDDebug, notification received here")
                }
                Task {
                    await checkStatus()
                }
                
            }.onAppear{
                // PermissionView()
                
                checkCameraPermission()
                
                // checkMicroPhonePermission()
                //checkPushNotificationPermission()
                
            }.alert(isPresented: $showSettingsAlert ) {
                Alert(
                    title: Text("Camera/M/P Access Denied"),
                    message: Text("Please enable camera access in Settings."),
                    primaryButton: .default(Text("Settings"), action: {
                        openSettings()
                    }),
                    secondaryButton: .cancel()
                )
            }.onAppear{
                // PermissionView()
                checkMicroPhonePermission()
            }.alert(isPresented: $microphoneshowSettingsAlert) {
                Alert(
                    title: Text("Microphone Access Denied"),
                    message: Text("Please enable MIcrophone access in Settings."),
                    primaryButton: .default(Text("Settings"), action: {
                        //  openMicrophoneSettings()
                        openSettings()
                    }),
                    secondaryButton: .cancel()
                )
            }
            .onAppear{
                // PermissionView()
                checkPushNotificationPermission()
            }.alert(isPresented: $pushnotificationshowSettingsAlert) {
                Alert(
                    title: Text("PUSH Notification Access Denied"),
                    message: Text("Please enable PUSH Notification access in Settings."),
                    primaryButton: .default(Text("Settings"), action: {
                        // openPushNotificationSettings()
                        openSettings()
                    }),
                    secondaryButton: .cancel()
                )
            }
            
            
        }
    }
    
}

/*
#Preview {
    VFMPMainView()
}
*/





