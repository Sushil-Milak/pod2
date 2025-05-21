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





struct FMPSessionQuestionView2: View {
    //@Binding var path: NavigationPath
    @State private var isFMPSessionSubmitView2Presented = false
    @Binding var isFMPSessionQuestionView2Presented: Bool
    @Binding var isFMPSessionLaunchView2Presented: Bool
    @Environment(\.dismiss) var dismiss1
    
    @StateObject private var notificationManager = NotificationManager()
    @State private var beneName: String = ""
    @State private var reasonForCall: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    @State private var isNameChecked = false
   
 
    var body: some View {
        GeometryReader { geometry in
            ZStack {
          //      Text("Third Level View")
                
                VStack {
                    if(!notificationManager.hasPermission){
                        PermissionView()
                    }
                    else{
                        
                        VStack(alignment: .leading){
                            Group{
                                Text("FMP Session Questions ").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
                                //.accessibilityAddTraits(.isHeader)
                                Text("Before your FMP representative session, we need to collect some details. Tap **NEXT** to continue").foregroundColor(Color.black).padding(.leading).padding(.bottom)
                                
                                Text("Your Name").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
                                TextField("", text: $beneName, prompt: Text("Enter Name").foregroundColor(.gray)).padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.blue, lineWidth: geometry.size.width / 500) // Dynamic width
                                    ).onChange(of: beneName){ newValue in
                                        UserDefaults.standard.set(beneName,forKey: "beneName")
                                    }
                                   
                              
                                Button(action: {
                                    isNameChecked.toggle()
                                    if isNameChecked {
                                        UserDefaults.standard.set(beneName,forKey: "beneName")
                                    }else{
                                        UserDefaults.standard.removeObject(forKey: "beneName")
                                    }
                                   }){
                                    
                                    HStack {
                                      
                                        Image(systemName: isNameChecked ? "checkmark.square" : "square")
                                        Text("Remember Me")
                                    }
                                   }.padding(.bottom)
                                
                                Text("How can we help you today? ").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
                                TextField("", text: $reasonForCall, prompt: Text("Reason for call").foregroundColor(.gray)).padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.blue, lineWidth: geometry.size.width / 500) // Dynamic width
                                    ).onChange(of: reasonForCall){ newValue in
                                        UserDefaults.standard.set(self.reasonForCall,forKey: "requestDesc")
                                    }
                                
                                
                                /*
                                Text("Phone ").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
                                TextField("###-###-####", text: $phoneNumber).padding(.leading).padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.blue, lineWidth: geometry.size.width / 500) // Dynamic width
                                    )
                                
                                Text("Email ").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
                                TextField("", text: $email).padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.blue, lineWidth: geometry.size.width / 500) // Dynamic width
                                    )
                                */
                            }
                            /*
                            VStack{
                                
                                /*
                                 NavigationLink(destination: FMPSessionSubmitView( path: $path, beneName1: self.beneName, reasonForCall: self.reasonForCall,phoneNumber: self.phoneNumber, email: self.email))
                                 */
                                NavigationLink(destination: FMPSessionSubmitView( path: $path, beneName1: self.beneName, reasonForCall: self.reasonForCall))
                                {
                                    HStack{
                                        
                                        Text(" Next ")
                                            .font(.title2)
                                            .bold()
                                            .frame(width: 200, height: 30)
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
                            }.padding(.bottom)
                            */
                            VStack{
                            Button{
                                
                                self.isFMPSessionSubmitView2Presented.toggle()
                             
                                
                            }
                            label: {
                                VStack(alignment:.leading){
                                    Text("Next")
                                        .font(.title2)
                                        .bold().accessibilityHint(Text("NEXT Button to submit this screen data"))
//                                        .cornerRadius(20)
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 20)
//                                                .stroke(Color.gray, lineWidth: 3)
//                                        ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
//                                        .padding(.all)
                                    
                                }
                            }.padding().background(Color("Primary_Navy"))
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white, lineWidth: 3)
                                    ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                        }
                            .sheet(isPresented: $isFMPSessionSubmitView2Presented){
                                FMPSessionSubmitView2(isFMPSessionSubmitView2Presented: $isFMPSessionSubmitView2Presented, isFMPSessionQuestionView2Presented: $isFMPSessionQuestionView2Presented,
                                                      isFMPSessionLaunchView2Presented: $isFMPSessionLaunchView2Presented,
                                                      beneName1: self.beneName, reasonForCall: self.reasonForCall )
                                }
                            /*
                            .sheet(isPresented: $isFMPSessionSubmitView2Presented){
                                TestView1(isPresented1: $isFMPSessionQuestionView2Presented, isFMPSessionLaunchView2Presented: $isFMPSessionLaunchView2Presented )
                                }
                            */
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
