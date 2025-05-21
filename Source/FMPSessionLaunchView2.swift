//
//  FMPSessionLaunchView.swift
//  beneproto
//
//  Created by sushil on 3/29/25.
//

import SwiftUI

struct FMPSessionLaunchView2: View {
    
    @Binding var isFMPSessionLaunchView2Presented: Bool
    @Environment(\.dismiss) var dismiss2
    @State private var isFMPSessionQuestionViewPresented = false
    //@Binding var path: NavigationPath
    @StateObject private var notificationManager = NotificationManager()
    @State private var beneName: String = ""
    @State private var reasonForCall: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    @State private var isNameChecked = false
    
    
    var body: some View {
        /*
         //MARK:Debug
        let _ = Self._printChanges()
        Text("FMPView2: What could possibly go wrong?")
        */
        GeometryReader { geometry in
            ZStack {
                VStack {
                    
                    if(!notificationManager.hasPermission){
                        PermissionView()
                    }
                    else{
                        
                        VStack(alignment: .leading){
                            Group{
                                Text("How to contact our VFMP staff").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
                                //.accessibilityAddTraits(.isHeader)
                                Text("You can contact us in any of these ways:").foregroundColor(Color.black).padding(.leading).padding(.bottom)
                                
                                Text("Option 1: Virtual Video Session").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
                                Text("Connect with a VFMP representationv live through the VFMP mobile app.").foregroundColor(Color.black).padding(.leading).padding(.bottom)
                                
                                Text("**Please Note:** Camera, Microphone, and PUSH Notifications will need to be enabled to connect with a VFMP representative").foregroundColor(Color.black).padding(.leading, 10).padding(.bottom)
                                
                                VStack{
                                Button{
                                    
                                    self.isFMPSessionQuestionViewPresented.toggle()
                                 
                                    
                                }
                                label: {
                                    VStack(alignment:.leading){
                                        Text("Connect with a VFMP representative")
                                            .font(.title2)
                                            .bold()
                                            .accessibilityHint(Text("Button to Connect with a VFMP representative"))
                                        
                                    }
                                }.padding().background(Color("Primary_Navy"))
                                        .foregroundColor(.white)
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.white, lineWidth: 3)
                                        ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                            }
                                .sheet(isPresented: $isFMPSessionQuestionViewPresented){
                                    FMPSessionQuestionView2(isFMPSessionQuestionView2Presented: $isFMPSessionQuestionViewPresented, isFMPSessionLaunchView2Presented: $isFMPSessionLaunchView2Presented )
                                    }
                              
                                
                                Text("Option 2: Online").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
                                Text("Connect with us online through **Ask VA**").foregroundColor(Color.black).padding(.leading).padding(.bottom)
                                
                                Text("Option 3: By email").bold().foregroundColor(Color.black).font(.headline).padding(.leading)
                                Text("Email us at HAC.FMP@va.gov. To protect your privacy, don't send sensitive personal or health care information through email").foregroundColor(Color.black).padding(.leading).padding(.bottom)
                               
                                
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
    FMPSessionLaunchView()
}
*/
