//
//  MainContentView.swift
//  beneproto
//
//  Created by sushil on 2/13/25.
//

import Foundation
import SwiftUI
import AzureCommunicationCalling
import AVFoundation
import UserNotifications
import Firebase
import FirebaseAnalytics

import WebKit


struct TileView2<Destination: View>: View {
  let title: String
  let destination: Destination
    @Binding var path: NavigationPath // passing path as a binding

  var body: some View {
    NavigationLink(destination: destination) {
      VStack {
        Text(title)
          .font(.headline)
          .foregroundColor(.primary)
      }
      .padding()
      .frame(width: 250, height: 100)
      .cornerRadius(12)
      .background(Color.blue)
    }
    .buttonStyle(PlainButtonStyle())
  }
}

struct MainContentViewWithRoutes: View {
    @ObservedObject var userSettings = UserSettings()
    @EnvironmentObject private var routerManager: NavigationRouter
    @EnvironmentObject private var NotificationManger_shared: NotificationManager
    @StateObject private var notificationManager = NotificationManager()
    @State private var mainNpath = NavigationPath()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .trailing){
              //  NavigationStack(path: $mainNpath) {
                NavigationStack(path: $routerManager.routes) {
                    
                    List {
                        
                        //MARK: Add VCL module
                        NavigationLink(value: Route.menuItem(item: vcl)){
                            VclView(vcl: vcl)
                        }.padding().background(Color("Primary_Navy"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 3)
                            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                        
                        //Mark: Add CHAMPVA module
                        NavigationLink(value: Route.menuItem(item: video)){
                                //VideoView(video: video)
                            ChampvaView(video: video)
                            }.padding().background(Color("Primary_Navy"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 3)
                            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                        
                        
                        //MARK: Add FMP module
                        NavigationLink(value: Route.menuItem(item: chat)){
                            //ChatView(chat: chat)
                            FMPView(chat: chat)
                        }.padding().background(Color("Primary_Navy"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.white, lineWidth: 3)
                            ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10).padding(.horizontal)
                       
                    }.listStyle(.insetGrouped)
                        .toolbar {
                                            ToolbarItem(placement: .principal) {
                                                HStack {
                                                    Text("Veteran & Family Member Program")
                                                        //.font(.callout)
                                                        .font(.headline)
                                                }
                                            }
                            /*
                            
                                            ToolbarItem(placement: .navigationBarLeading) {
                                                Button("Back") {
                                                    dismiss()
                                                }
                                            }
                                           ToolbarItem(placement: .navigationBarTrailing) {
                                               Button("Save") {
                                                   print("Save action")
                                               }
                                           }
                            */
                                        }
                        .navigationDestination(for: Route.self){ route in
                        route
                        // ChampvaMainView()
                     }
                   
                  
                    
                }
                /*
                VStack {
                  //  RotatingTextBanner(text: "Check out HOME app for PACT ACT")
                    LeftToRightRotationTextBanner(text: "Check out HOME app for PACT ACT")
                }
                */
            }.onAppear( perform: {
                    Analytics.logEvent(AnalyticsEventScreenView,
                                       parameters: [AnalyticsParameterScreenName: "\(MainContentViewWithRoutes.self)",
                                                   AnalyticsParameterScreenClass: "\(MainContentViewWithRoutes.self)"])
                }).onReceive(NotificationCenter.default.publisher(for: Notification.Name("didReceiveRemoteNotification"))){ notification in
                    if let data = notification.object as? String {
                                       //path.append(data)
                      //  mainNpath.append(VFMPMainView(path: $mainNpath))
                        
                        print("DDDebug, notification received here")
                                   }
                    //checkStatus()
                }
        }
       
    }
    
}
