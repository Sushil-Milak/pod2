//
//  MyCustomViewController.swift
//  beneproto
//
//  Created by sushil on 2/20/25.
//

import Foundation
import UIKit

class PermissionViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        NotificationStatusCheck.shared.currentViewController(self)
    
    }
    
   
}



