//
//  test1.swift
//  voice_video_version1
//
//  Created by sushil on 12/18/24.
//

import Foundation
//import AzureCommunicationCommon
//import AzureCommunicationCalling
//import AzureCommunicationCalling
import AzureCommunicationUICalling
import SwiftUICore

/*
import FirebaseCore
import FirebaseMessaging
import UserNotifications
import FirebaseAnalytics
import FirebaseCrashlytics

*/
import FirebaseCrashlytics

// TODO: Need class for Azure to work. Pulling this from viewmodel

public class ACSHelper {
    
    
    //may need list structure?
    var presenterId = ""
    var presenterAccessToken = ""
    var consumerId = ""
    var consumerAccessToken = ""
    var sessionStart = ""
    var sessionExpires = ""
    var roomId = ""
    var presenterURL = ""
    var accessToken = ""
    var participants: [MParticipant] = []
    var requestid = ""
    var threadId = ""
    //constants: old as of 01/30/2025 and replaced below, from SEAN
    /*
     let BASE_URL_SERVICE_API = "https://webapp-caa-service-api-develop.azurewebsites.net"
     let BASE_URL_INTERFACE_API = "https://webapp-caa-interface-api-develop.azurewebsites.net"
     let BASE_URL_ACS_SERVICE = "https://webapp-caa-acs-service-develop.azurewebsites.net"
     let BASE_URL_WEBEX_SERVICE = "https://webapp-caa-webex-service-develop.azurewebsites.net"
     */
    
    //latest as of 01/30/2025
    let BASE_URL_SERVICE_API = "https://ica.mapsandbox.net/service"
    let BASE_URL_INTERFACE_API = "https://ica.mapsandbox.net/interface"
    let BASE_URL_ACS_SERVICE = "https://ica.mapsandbox.net/acs"
    let BASE_URL_WEBEX_SERVICE = "https://ica.mapsandbox.net/webex"
    
    let ICA_ACS_MEETING = "https://ica.mapsandbox.net/ica/acs-meeting"
    let ICA_ACS_CREATE_ROOM = "https://ica.mapsandbox.net/service/room/createRoom"
    
    let ACS_TOKEN = "eyJ0eXAiOiJKV1QiLCJub25jZSI6IkVQcVdyQ05ucjRxUUd0S3NfNGxXMm83ZEhlVmx6SXJmb01sRFpwLUFPeE0iLCJhbGciOiJSUzI1NiIsIng1dCI6Ik1HTHFqOThWTkxvWGFGZnBKQ0JwZ0I0SmFLcyIsImtpZCI6Ik1HTHFqOThWTkxvWGFGZnBKQ0JwZ0I0SmFLcyJ9"
    
    
    private var callComposite: CallComposite?
    
   public func postCreateRoomCall5() async {
        // avoiding background thread approach: Task { }
        
        
        
        let guest1 = Guest(name:"Mark", email:"sushil.milak.va@gmail.com")
        let guestArray = Guests(guests: [guest1])
        guard let encodeGuestData = try? JSONEncoder().encode(guestArray) else {
            
            print("Failed to pass request data: Guest list")
            return
        }
        
        var postUrlString = "https://ica.mapsandbox.net/service/room/createRoom"
        guard let url = URL(string: postUrlString)
        else {
            // self.hasError = true
            fatalError("Check URL")
        }
        
        var req = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("Bearer \(ACS_TOKEN)", forHTTPHeaderField: "Authorization")
        req.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        req.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        req.addValue("keep-alive", forHTTPHeaderField: "connection")
        
        
        
        
        
        //TODO: what if there are no guest
        
        
        
        
        do {
            // let (data, _) = try await URLSession.shared.upload( for: req)
            //TODO: what if there are no guest
            let (data, _) = try await URLSession.shared.upload(for: req, from: encodeGuestData)
            let decodeData = try JSONDecoder().decode(CreateRoom.self, from: data)
            // self.createRoom = [decodeData]
            print("Debug: \(data)")
            //match with call
            self.roomId = decodeData.data.room.id
            // self.roomIdvm = decodeData.data.room.id
           // let participants = decodeData.data.participants
            self.participants = decodeData.data.participants
            
            
            
            
            for participant in participants {
                if participant.role.lowercased().starts(with: "presenter") {
                    self.presenterId = participant.data.user.communicationUserId
                    self.presenterAccessToken = participant.data.token
                    self.sessionExpires = participant.data.expiresOn
                    //construct presenter URL
                    // presenterURL = "https://ica.mapsandbox.net/ica/acs-meeting?roomId=\(roomId)&token=\(ACS_TOKEN)&id=\(participant.data.user.communicationUserID)&type=Presenter&name=Presenter"
                }
                else {
                    
                    self.consumerId = participant.data.user.communicationUserId
                    self.consumerAccessToken = participant.data.user.communicationUserId
                    //construct consumer URL
                    // consumerURL = "https://ica.mapsandbox.net/ica/acs-meeting?roomId=\(roomId)&token=\(ACS_TOKEN)&id=\(participant.data.user.communicationUserID)&type=Consumer&name=Consumer"
                }
                
                
                print("presenterId: \(self.presenterId)")
                print("presenterAccessToken: \(self.presenterAccessToken)")
                
                print("roomId: \(self.roomId)")
                
            }
        }
        catch {
            print ("post call failed: \(error)")
            // hasError = true
            // self.error = UserError.custom(error: error)
        }
        
        //   isLoading = false
        
        /*
         let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
         if let error = error {
         print(error.localizedDescription)
         } else if let data = data {
         let responseString = String(data: data, encoding: .utf8)
         print(responseString ?? "")
         }
         }
         task.resume()
         */
        
        
        
        /*
         let callees:[CommunicationIdentifier] = [CommunicationUserIdentifier(self.callee)]
         self.callAgent?.startCall(participants: callees, options: StartCallOptions()) {
         (call, error) in
         if (error == nil){
         self.call = call
         }
         else {
         print("Error, failed to get the call object")
         }
         }
         */
        
        
        
    }
    
    //for POSTMAN changes 03/06/2025
    
    public func decodeJSONWithoutModel(jsonData: Data) throws -> [String: Any] {
        let json1 = try JSONSerialization.jsonObject(with: jsonData, options:[]) as? [String: Any]
        guard let jsonDict = json1 else {
            throw DecodingError.typeMismatch([String: Any].self, DecodingError.Context(codingPath: [], debugDescription: "Not a dictionary inside Decoded Json"))
        }
        return jsonDict
    }
    
   public func postCancel() async {
        
        let requestId: String =  UserDefaults.standard.string(forKey:"requestId")! // "3ce3c6c7-42e5-4e33-a099-6558db6528f9"
        // ToDo
        // avoiding background thread approach: Task { }
        /*
        let requestApp:String = "VFMP-ios"
        let requestMobileId: String =  UserDefaults.standard.string(forKey:"requestMobileId")! // "3ce3c6c7-42e5-4e33-a099-6558db6528f9"
        let requestId: String =  UserDefaults.standard.string(forKey:"requestId")! // "3ce3c6c7-42e5-4e33-a099-6558db6528f9"
        let requestName: String = "Sean Tyler"
        let requestDesc: String = "What is the Meaning of Life for Bill?"
        
        let encounterRequest = encounterRequest(requestApp: requestApp, requestMobileId: requestMobileId, requestName: requestName, requestDesc: requestDesc)
        
        guard let encodeRequestData = try? JSONEncoder().encode(encounterRequest) else {
            
            print("Failed to pass request data: encounterRequest")
            return
        }
        */
        var postUrlString = "https://ica.mapsandbox.net/service/requests/" + requestId
        //postUrlString.append(requestid)
        guard let url = URL(string: postUrlString)
        else {
            // self.hasError = true
            fatalError("Check URL")
        }
        
        var req = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        req.httpMethod = "DELETE"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // do we need it
        // req.addValue("Bearer \(ACS_TOKEN)", forHTTPHeaderField: "Authorization")
        req.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        req.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        req.addValue("keep-alive", forHTTPHeaderField: "connection")
        
        //TODO: what if there are no guest
        
        do {
            // let (data, _) = try await URLSession.shared.upload( for: req)
            //TODO: what if there are no guest
            let (data, response) = try await URLSession.shared.data(for: req)      //(for: req, from:  encodeRequestData)
            guard let httpResonse = response as? HTTPURLResponse else {
                Crashlytics.crashlytics().log("ACSHELPER:Cancel:HttpResponse error: badServerResponse")
                throw URLError(.badServerResponse)
            }
          //  let decodedData = try JSONDecoder().decode(CreateICARequest.self, from: data)
        //    print("BDebug: data received from POST call to createEncounter request\(data)")
            do {
                        if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            // Process the JSON dictionary
                            print("JSON response: \(jsonDictionary)")
                            let status = jsonDictionary["status"] as? Int
                            if status == 200 {
                                // cancel requestId is successful
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
                      } else {
                            print("JSON response is not a dictionary or array.")
                        }
                    } catch {
                        //Crashlytics point
                        print("Error parsing JSON: \(error)")
                        //Crashlytics.crashlytics().log("ACSHELPER:Cancel:error: \(error)")
                    }
        
        }
        catch {
            print ("post call failed: \(error)")
           // Crashlytics.crashlytics().log("ACSHELPER:Cancel:error: \(error)")
            
        }
    }
    
   public func GetEncounterRequestStatus() async {
        // ToDo
        // if ACS token available then put them in userdefault, change flags
        
        if UserDefaults.standard.object(forKey: "requestId") != nil {
            let requestId: String =  UserDefaults.standard.string(forKey:"requestId")!
            UserDefaults.standard.set(0, forKey: "GetEncounterRequestStatus") // default=0, i.e; GetEncounterRequestStatus = No success
            var postUrlString = "https://ica.mapsandbox.net/service/requests/" + requestId
            print("DebugA: GetEncounterRequestStatus:\(requestId) ")
            guard let url = URL(string: postUrlString)
            else {
                // self.hasError = true
                fatalError("Check URL")
              //  Crashlytics.crashlytics().log("ACSHELPER:EncounterRequest:error: ")
            }
            var req = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
            req.httpMethod = "GET"
            //req.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //req.addValue("text/plain", forHTTPHeaderField: "Content-Type")
            // req.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
            //req.addValue("application/json", forHTTPHeaderField: "Accept")
            req.addValue("*/*", forHTTPHeaderField: "Accept")
            req.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
            req.addValue("keep-alive", forHTTPHeaderField: "Connection")
            do {
                let (data, response) = try await URLSession.shared.data(for: req)      //(for: req, from:  encodeRequestData)
                guard let httpResonse = response as? HTTPURLResponse else {
              //      Crashlytics.crashlytics().log("ACSHELPER:EncounterRequest:HttpResponse error: badServerResponse")
                    throw URLError(.badServerResponse)
                    
                }
                
                
                let decodedData = try JSONDecoder().decode(CreateICARequest.self, from: data)
                let trequestId = decodedData.result?.requestid
                let tplaceinqueue = decodedData.result?.placeinqueue
                print("trequestId : \(trequestId )")
                print("tplaceinqueue : \(tplaceinqueue )")
                
                print("DebugA: GetEncounterRequestStatus:\(requestId) ")
              
                if trequestId == requestId {
                    UserDefaults.standard.set(tplaceinqueue, forKey: "placeinqueue")
                    UserDefaults.standard.set(1, forKey: "GetEncounterRequestStatus") // when GetEncounterRequestStatus is a SUCCESS
                }
                else{
                 //   Crashlytics.crashlytics().log("ACSHELPER:RequestEncounter:error: mismatch or requestid not found ")
                }
            
            }
            catch {
                print ("post call failed: \(error)")
            //    Crashlytics.crashlytics().log("ACSHELPER:RequestEncounter:error: \(error)")
                
            }
        }
        else {
            return
        }
        /*
        let userDefaults = UserDefaults.standard
        let dictionary = userDefaults.dictionaryRepresentation()

         print("UserDefaults Contents:")
         for (key, value) in dictionary {
             print("\(key): \(value)")
         }
        */
   
    }
    
   
    
    
   public func postNonPushNotificationMethod() async throws {
        // avoiding background thread approach: Task { }
        
        if UserDefaults.standard.object(forKey: "requestId") != nil {
            
            let requestId: String = UserDefaults.standard.string(forKey: "requestId")!
            print("Debug0:postNonPushNotificationMethod: requestId, \(requestId) ")
            let NonPushencounterRequest = NonPushEncounterRequest( requestId: requestId)
           
            guard let encodeRequestData = try? JSONEncoder().encode(NonPushencounterRequest) else {
                
                print("Failed to pass request data: encounterRequest")
                return
            }
            
        //    var postUrlString = "https://ica.mapsandbox.net/service/requests"
            var postUrlString = "https://ica.mapsandbox.net/service/requests/" + requestId
            guard let url = URL(string: postUrlString)
            else {
                // self.hasError = true
                fatalError("Check URL")
            }
            
            var req = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
            req.httpMethod = "GET"
            //req.addValue("application/json", forHTTPHeaderField: "Content-Type")
           // req.addValue("text/plain", forHTTPHeaderField: "Content-Type")
           // do we need it
            // req.addValue("Bearer \(ACS_TOKEN)", forHTTPHeaderField: "Authorization")
           // req.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
            //req.addValue("application/json", forHTTPHeaderField: "Accept")
            req.addValue("*/*", forHTTPHeaderField: "Accept")
            req.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
            //req.addValue("keep-alive", forHTTPHeaderField: "connection")
            req.addValue("keep-alive", forHTTPHeaderField: "Connection")
            
            //TODO: what if there are no guest
            
            do {
                // let (data, _) = try await URLSession.shared.upload( for: req)
                //TODO: what if there are no guest
               //works for json let (data, response) = try await URLSession.shared.upload(for: req, from: encodeRequestData)      //(for: req, from:  encodeRequestData)
              //  let (data, response) = try await URLSession.shared.upload(for: req, from: encodeRequestData)
                let (data, response) = try await URLSession.shared.data(for: req)
                guard let httpResonse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                let decodedData = try JSONDecoder().decode(CreateRoomNonPush.self, from: data)
                
             //   roomId = decodedData.result.
                let meetingInfo = decodedData.result.meetinginfo
                let userData = meetingInfo.userData
                let roomData = meetingInfo.roomData
                let threadData = meetingInfo.threadData
                
                for userDataItem in userData {
                    if userDataItem.role.lowercased().starts(with: "presenter") {
                        self.presenterId = userDataItem.id.communicationUserId
                        self.presenterAccessToken = userDataItem.token
                        print("Debug0:presenterId, \(self.presenterId) ")
                        print("Debug0:presenterAccessToken, \(self.presenterAccessToken) ")
                    }else {
                        self.consumerId = userDataItem.id.communicationUserId
                        self.consumerAccessToken = userDataItem.token
                        print("Debug0:consumerId , \(self.consumerId ) ")
                        print("Debug0:consumerAccessToken, \(self.consumerAccessToken) ")
                        UserDefaults.standard.set(self.consumerId, forKey: "chat_user_identity")
                        
                        UserDefaults.standard.set(self.consumerAccessToken, forKey: "chat_user_token")
                    }
                    
                }
                
                self.roomId = roomData.id
                if(self.roomId != nil) {
                    UserDefaults.standard.set(self.roomId, forKey: "roomId")
                    print("Debug0:self.roomId, \(self.roomId ) ")
                }
                
                self.threadId = threadData.chatThread.id
                if(self.threadId != nil) {
                    UserDefaults.standard.set(self.threadId, forKey: "chatThreadId")
                    print("Debug0:self.threadId, \(self.threadId ) ")
                }
        
               
           
            }
            catch {
                print ("post call failed:PostNonPushNotificationMethod \(error)")
                
            }
        }
        else{
            
        }
        

        
        
        
    }
    
   public func postCreateRequests() async throws {
        // avoiding background thread approach: Task { }
        
        
        let requestApp:String = "FM"
        
        let requestMobileId: String =  UserDefaults.standard.string(forKey:"requestMobileId")! // "3ce3c6c7-42e5-4e33-a099-6558db6528f9"
        let requestName: String =  UserDefaults.standard.string(forKey: "beneName") ?? "No Description"  //"CreateBeneEncounterRequest"
        let requestDesc: String = UserDefaults.standard.string(forKey: "requestDesc") ?? "No Description" // || "What is the Meaning of Life for Bill?"
       // let requestEmail: String = "a@a.com"
        let requestClientType: String = "iOS"
        let requestFirebaseProjectId:String = "beneproto-80214"
        
       // var params = "requestMobileId=\(requestMobileId)"+"&requestName\(requestName)"+"&requestDesc\(requestDesc)"+"&requestEmail\(requestEmail)"
        var params = "requestMobileId=\(requestMobileId)"+"&requestName=\(requestName)"+"&requestDesc=\(requestDesc)"+"&requestClientType=\(requestClientType)"+"&requestFirebaseProjectId=\(requestFirebaseProjectId)"
        
        guard let paramData = params.data(using: .utf8) else
        {
            print("Failed to encode text")
            return
        }
        
        let encounterRequest = encounterRequest(requestApp: requestApp, requestMobileId: requestMobileId, requestName: requestName, requestDesc: requestDesc, requestClientType: requestClientType, requestFirebaseProjectId: requestFirebaseProjectId)
        
        guard let encodeRequestData = try? JSONEncoder().encode(encounterRequest) else {
            
            print("Failed to pass request data: encounterRequest")
            return
        }
        
        var postUrlString = "https://ica.mapsandbox.net/service/requests"
        guard let url = URL(string: postUrlString)
        else {
            // self.hasError = true
            fatalError("Check URL")
        }
        
        var req = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //req.addValue("text/plain", forHTTPHeaderField: "Content-Type")
       // do we need it
        // req.addValue("Bearer \(ACS_TOKEN)", forHTTPHeaderField: "Authorization")
        req.addValue("no-cache", forHTTPHeaderField: "Cache-Control")
        //req.addValue("application/json", forHTTPHeaderField: "Accept")
        req.addValue("*/*", forHTTPHeaderField: "Accept")
        req.addValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
        //req.addValue("keep-alive", forHTTPHeaderField: "connection")
        req.addValue("keep-alive", forHTTPHeaderField: "Connection")
        
        //TODO: what if there are no guest
        
        do {
            // let (data, _) = try await URLSession.shared.upload( for: req)
            //TODO: what if there are no guest
           //works for json let (data, response) = try await URLSession.shared.upload(for: req, from: encodeRequestData)      //(for: req, from:  encodeRequestData)
           //works for text let (data, response) = try await URLSession.shared.upload(for: req, from: paramData)
            let (data, response) = try await URLSession.shared.upload(for: req, from: encodeRequestData)
            guard let httpResonse = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse)
            }
            let decodedData = try JSONDecoder().decode(CreateICARequest.self, from: data)
            let trequestId = decodedData.result?.requestid
            let tplaceinqueue = decodedData.result?.placeinqueue
            print("trequestId : \(trequestId )")
            print("tplaceinqueue : \(tplaceinqueue )")
            
            UserDefaults.standard.set(trequestId, forKey: "requestId")
            UserDefaults.standard.set(tplaceinqueue, forKey: "placeinqueue")
     
        }
        catch {
            print ("post call failed: \(error)")
            
        }
        
        
        
    }
    
    
    
   public func startCallComposite(selectedRoomId: String, selectedUserId: String,  selectedUserToken: String){
        
        //ACS stuff
        let communicationTokenCredential = try! CommunicationTokenCredential(token: selectedUserToken)
        let communicationIdentifier = CommunicationUserIdentifier(selectedUserId)
        let callCompositeOptions = CallCompositeOptions(displayName:"Bene", userId: communicationIdentifier)
        
        callComposite = CallComposite(credential: communicationTokenCredential, withOptions: callCompositeOptions)
        
        var localOptions = LocalOptions(
            participantViewData: ParticipantViewData(displayName: "ICA Bene Tester"),
            setupScreenViewData: SetupScreenViewData(title: "Screen Title", subtitle: "sub title"),
            cameraOn: true,
            microphoneOn: true,
            skipSetupScreen: true,
            audioVideoMode: CallCompositeAudioVideoMode.audioAndVideo,
            captionsOptions: CaptionsOptions(captionsOn: true)
        )
        
        //run on main thread
        // area to decide where to put call: room, teams, group call?
        DispatchQueue.main.async {
            //  self.callComposite?.launch(locator: .roomCall(roomId: selectedRoomId), localOptions: localOptions)
            self.callComposite?.launch(locator: .roomCall(roomId: self.roomId), localOptions: localOptions)
        }
    }
    
   public func startChatComposite(selectedUserId: String,  selectedUserToken: String){
        
        let communicationIdentifier = CommunicationUserIdentifier(selectedUserId)
        guard let communicationTokenCredential = try? CommunicationTokenCredential(
                    token: selectedUserToken) else {
                    return
                }
        
    }
}
