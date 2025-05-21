//
//  MyViewControllerWrapper.swift
//  beneproto
//
//  Created by sushil on 2/20/25.
//

import Foundation
import SwiftUI
import UIKit

struct MyViewControllerWrapper: UIViewControllerRepresentable {
  
    
    @Binding var path: NavigationPath
   //work typealias UIViewControllerType = MyCustomViewController
    typealias UIViewControllerType = UINavigationController
    
    func makeUIViewController(context: Context) -> UINavigationController {
   // func makeUIViewController(context: Context) -> MyCustomViewController {
        // works but no back navigation return MyCustomViewController()
        let viewController = MyCustomViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    //func updateUIViewController(_ uiViewController: MyCustomViewController, context: Context) {
        // this method is called when SwuftUI view updates
        // we can update the view controller here
    }
    
    
    
    
}
