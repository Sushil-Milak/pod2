//
//  FMPSessionQuestionView.swift
//  beneproto
//
//  Created by sushil on 3/6/25.
//

import SwiftUI
import AzureCommunicationCalling
import AVFoundation
import UserNotifications
import FirebaseCrashlytics




struct FMPSessionSubmitView2: View {
    //@Binding var path: NavigationPath
    @State private var isVFMPMainViewRPresented = false
    @Binding var isFMPSessionSubmitView2Presented: Bool
    @Binding var isFMPSessionQuestionView2Presented: Bool
    @Binding var isFMPSessionLaunchView2Presented: Bool
    @Environment(\.dismiss) var dismiss_FMPSessionSubmitView2
    @StateObject private var notificationManager = NotificationManager()
    @State private var showAlert = false
    @State private var navigate = false
    @State private var taskCompleted = false
   // @State private var path1 = NavigationPath()
    let beneName1: String
    let reasonForCall: String
 //   let phoneNumber: String
 //   let email: String
    var acsHelper = ACSHelper()
    @Environment(\.dismiss) var dismiss
    @State private var shouldCallAPI = false
    
    func checkAndUpdateEncounterRequestPresence(){
        
        
        if UserDefaults.standard.string(forKey: "requestId") != nil {
            self.shouldCallAPI = false
        }
        else{
            self.shouldCallAPI = true
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
               
                VStack{
                    if(!notificationManager.hasPermission){
                        PermissionView()
                    }
                    else{
                        
                        VStack(alignment: .leading){
                            Group {
                                //   Text("FMP Session Questions  ").bold().foregroundColor(Color.black).font(.title).padding(.leading).padding(.bottom)
                                Divider()
                                
                                HStack {
                                    Spacer()
                                    Rectangle().frame(width: 100, height: 5).foregroundColor(Color("Primary_Navy")).background(Color("Secondary_Sand"))
                                    Spacer()
                                    Rectangle().frame(width: 100, height: 5).foregroundColor(Color("Primary_Navy")).background(Color("Secondary_Sand"))
                                    //Rectangle().frame(width: 100, height: 1).fill(Color.blue)
                                    Spacer()
                                    
                                }
                                
                                Text("Please review the information below and tap \"Submit\" when ready ").bold().foregroundColor(Color.black).font(.headline).padding(.leading).padding(.bottom)
                                //.accessibilityAddTraits(.isHeader)
                                VStack {
                                    Text("Your Name:").bold().foregroundColor(Color.black).font(.headline).padding(.leading).padding(.bottom)
                                   // Text(self.beneName1).foregroundColor(Color.black).padding(.leading).padding(.bottom)
                                    Group {
                                        if !self.beneName1.isEmpty {
                                            Text(self.beneName1).padding(.leading)
                                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 2))
                                        }
                                        else {
                                            Text("NO-Name").foregroundColor(.gray) // Indicate it's a default value
                                                                .padding(.leading)
                                                                .overlay(
                                                                    RoundedRectangle(cornerRadius: 5)
                                                                        .stroke(Color.gray, lineWidth: 1) // Different border for default
                                                                )
                                        }
                                    }.padding(.bottom)
                                }
//                                Text("Your Name:").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
//                               // Text(self.beneName1).foregroundColor(Color.black).padding(.leading).padding(.bottom)
//                                Group {
//                                    if !self.beneName1.isEmpty {
//                                        Text(self.beneName1).padding().overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 2))
//                                    }
//                                    else {
//                                        Text("NO-Name").foregroundColor(.gray) // Indicate it's a default value
//                                                            .padding()
//                                                            .overlay(
//                                                                RoundedRectangle(cornerRadius: 5)
//                                                                    .stroke(Color.gray, lineWidth: 1) // Different border for default
//                                                            )
//                                    }
//                                }
                                
//                                Text("How can we help you today:").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
//                                Text(self.reasonForCall).foregroundColor(Color.black).padding(.leading).padding(.bottom)
                                VStack {
                                    Text("How can we help you today:").bold().foregroundColor(Color.black).font(.headline).padding(.leading).padding(.bottom)
                                   
                                    Group {
                                        if !self.reasonForCall.isEmpty {
                                            Text(self.reasonForCall).padding(.leading)
                                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 2))
                                        }
                                        else {
                                            Text("Blank").foregroundColor(.gray) // Indicate it's a default value
                                                .padding(.leading)
                                                .overlay(RoundedRectangle(cornerRadius: 5)
                                                                        .stroke(Color.gray, lineWidth: 1) // Different border for default
                                                                )
                                                //.frame(maxWidth: .infinity, alignment: .leading)
                                               // .multilineTextAlignment(.leading) // Important for multi-line text
                                        }
                                    }.padding(.bottom)
                                }
                              
                                //MARK:Sheet Logic
                                VStack{
                                    
                                    
                                    Button{
                                        Task{
                                            if self.shouldCallAPI{
                                                do {
                                                    try await acsHelper.postCreateRequests()
                                                    print("BDebug button task postCreateRoomCall6 completed successfully")
                                                    showAlert = true
                                                  
                                                }
                                                catch{
                                                    print("Error: \(error)")
                                                }
                                            }
                                            else {
                                                Crashlytics.crashlytics().log("FMPSessionSubmitView2: RequestID exist. Disallowing api call ")
                                            }
                                            
                                        }
                                        self.isVFMPMainViewRPresented.toggle()
                                        isFMPSessionLaunchView2Presented = false
                                        dismiss_FMPSessionSubmitView2()
                                    }
                                    label: {
                                        VStack(alignment:.leading){
                                            Text("Submit")
                                                .font(.title2)
                                                .bold().accessibilityHint(Text("Button to SUBMIT screen data"))
//                                                .cornerRadius(20)
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 20)
//                                                        .stroke(Color.gray, lineWidth: 3)
//                                                ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                                                .padding(.all)
                                            
                                        }
                                    }.padding().background( Color("Primary_Navy"))
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.white, lineWidth: 3)
                                        ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                                    
                                }
                                .onAppear{
                                            checkAndUpdateEncounterRequestPresence()
                                         }
                                .alert(isPresented: $showAlert){
                                            Alert(
                                                    title: Text("Almost Done"),
                                                    message: Text("Thank you. Please wait for a notification. Add more..."),
                                                    dismissButton: .default(Text("OK")){
                                                        navigate = true
                                                        taskCompleted = true
                                                        //path.append("FMPSessionWaitingView") // navigate after OK button is pressed.
                                                    }
                                            )
                                        }
                                
                            
                                
                                
                                
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

/*
#Preview {
    FMPSessionQuestionView()
}
*/
