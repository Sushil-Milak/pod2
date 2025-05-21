//
//  ContentView.swift
//  iosPod
//
//  Created by sushil on 5/1/25.
//

import SwiftUI
import pod1
//import MyReusablePod
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        VStack {
            
            pod1.MyReusableView(title: "From My Pod")
                        .padding()
        }
        VStack {
            
            pod1.VFMPMainViewR(title: "Second")
                        .padding()
        }
    }
}

#Preview {
    ContentView()
}
