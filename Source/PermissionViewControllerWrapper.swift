//
//  MyViewControllerWrapper.swift
//  beneproto
//
//  Created by sushil on 2/20/25.
//

import Foundation
import SwiftUI
import UIKit

struct PermissionViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = PermissionViewController
    
    func makeUIViewController(context: Context) -> PermissionViewController {
        return PermissionViewController()
    }
    
    func updateUIViewController(_ uiViewController: PermissionViewController, context: Context) {
        // this method is called when SwuftUI view updates
        // we can update the view controller here
    }
    
    
    
    
}
