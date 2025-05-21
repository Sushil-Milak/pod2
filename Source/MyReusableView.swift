//
//  MyReusableView.swift
//  Pods
//
//  Created by sushil on 5/2/25.
//

import SwiftUI

public struct MyReusableView: View {
    let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        Text("Hello, \(title)!")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

//final public class MyReusableView: SwiftUI.View {
//    let title: String
//
//    public init(title: String) {
//        self.title = title
//    }
//
//    public var body: some View {
//        Text("Hello, \(title)!")
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//    }
//}
