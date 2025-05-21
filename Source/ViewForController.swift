//
//  ViewForController.swift
//  beneproto
//
//  Created by sushil on 2/20/25.
//

import SwiftUI
import AVFoundation
import AzureCommunicationCalling
import AzureCommunicationChat


struct ViewForController: View {
    @Binding var path: NavigationPath // pass the path as a binding
    var displayName: String?
    @State private var navigate = false
   // var chat: Chat
    @State var message: String = ""
    @State var chatThreadId: String = ""
    
 

      // Calling state
    @State var callClient: CallClient?
    @State var callObserver: CallDelegate?
    @State var callAgent: CallAgent?
    @State var call: Call?

      // Chat state
      @State var chatClient: ChatClient?
      @State var chatThreadClient: ChatThreadClient?
      @State var chatMessage: String = ""
      @State var meetingMessages: [MeetingMessage] = []
    
    //Globals
    let chat_displayName = "DisplayName"
    let chat_userDisplayName = "Bene"
    let chat_CSRDisplayName = "CSR"
    let chat_userId = "BeneId"
    let chat_endPoint = "https://acsicatest.unitedstates.communication.azure.com/" // this could from infolist or similar resource file
    let roomId1 = UserDefaults.standard.string(forKey: "roomId") ?? "NoValue"
    let chat_user_identity = UserDefaults.standard.string(forKey: "chat_user_identity") ?? "NoValue"
    
    var body: some View {
            VStack {
                
                Text("Room:\(roomId1)")
                Text("chat_user_identity:\(chat_user_identity)")
                
                NavigationView {
                    VStack {
                        
                        NavigationLink( destination: MyViewControllerWrapper(path: $path),isActive: $navigate ) //.navigationTitle("test2"))
                        {
                            EmptyView()
                        }
                        
                        Button(action: {
                            Task{
                                do {
                                    navigate = true
                                }
                                catch{
                                    print("Error: \(error)")
                                }
                            }
                        }, label: {
                            VStack{
                                Text("Join CSR Call ")
                                    .font(.title2)
                                    .bold()
//                                    .frame(width: 200, height: 30)
//                                    .cornerRadius(20)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 20)
//                                            .stroke(Color.gray, lineWidth: 3)
//                                    ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                                    .padding(.all)
                                    .accessibilityHint(Text("Button to Join CSR Call"))
                            }
                        }).padding().background(Color("Primary_Navy"))
                            .foregroundColor(.red)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 3)
                            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                    }//.navigationTitle("ViewForController")
                    
                    //MyViewControllerWrapper(path: $path).navigationTitle("test2")
                }
                /*
                NavigationLink(destination:  MyViewControllerWrapper(path: $path),isActive: $navigate ){
                    EmptyView()
                }
                Button(action: {
                    Task{
                        do {
                        
                            navigate = true
                            
                        }
                        catch{
                            print("Error: \(error)")
                        }
                    }
                }, label: {
                    VStack{
                        Text(" Submit ")
                            .font(.title2)
                            .bold()
                            .frame(width: 200, height: 30)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray, lineWidth: 3)
                            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .padding(.all)
                            .accessibilityHint(Text("Button to SUBMIT FMP Session Questions."))
                    }
                })
                */
              //works   MyViewControllerWrapper() // display the UIViewController
                
            }
        }
    }

    /*
    #Preview {
        ViewForController()
    }
    */
  
