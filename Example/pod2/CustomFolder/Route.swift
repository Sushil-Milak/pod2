//
//  Route.swift
//  beneproto
//
//  Created by sushil on 1/23/25.
//

import Foundation
import SwiftUI
import VCL
import pod1


//TODO: make hashable
// make view

enum Route: View, Hashable {
    case menuItem(item: any MenuItem)  // any model that conforms to this protocol
    
    
    func hash( into hasher: inout Hasher){
        hasher.combine(self.hashValue)
    }
    
    // define Equatable
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs,rhs) {
        case (.menuItem(let lhsItem), .menuItem(let rhsItem)):
            return lhsItem.id == rhsItem.id
        default:
            return false
        }
    }
    
    var body: some View {
        switch self {
        case .menuItem(let item):
            switch item {
                
            case is Video:
              //works  VideoDetailView(video: item as! Video)  // need to hardcast as it is protocol
              //  VideoDetailView3(video: item as! Video)  // need to hardcast as it is protocol
              // original. Need adaption. Create separate pod or SPM and Uncomment later.  ChampvaMainView() // need to hardcast as it is protocol
                Sampler1()
            case is Chat:
               
                 //original. Need adaption. VFMPMainViewR()
                //pod1.VFMPMainViewR(title: "Second")
                pod1.
                
                //Match with Module defination
            case is Vcl_module:
                  // comes from VCL_ios SPM
                VCL.VeteransCrisisLineSectionView()
            default:
                EmptyView()
            }
            
        }
        
    }
}
