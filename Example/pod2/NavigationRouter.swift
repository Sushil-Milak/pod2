//
//  NavigationRouter.swift
//  beneproto
//
//  Created by sushil on 1/23/25.
//

import Foundation
import SwiftUI

final class NavigationRouter: ObservableObject {
    
   // @Published var routes = NavigationPath()
    @Published var routes = [Route]()
    
    func push(to screen: Route){
        
        guard !routes.contains(screen) else {
            return
        }
        routes.append(screen)
    }
    
    // to empty the navigationpath
    func reset() {
    //    routes.removeLast(routes.count)
        routes = []
    }
    
    func goBack(){
        _ = routes.popLast()
    }
}
