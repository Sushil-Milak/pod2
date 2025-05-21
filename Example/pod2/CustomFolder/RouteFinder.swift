//
//  DeepLinkURLs.swift
//  beneproto
//
//  Created by sushil on 1/23/25.
//

import Foundation

enum DeepLinkURLs: String {
    //case menuItem
    case product = "product"
    case video = "video"
    case chat = "chat"
    case vcl = "vcl"
}

struct RouteFinder {
    
    
    func find(from url: URL) -> Route? {
        
        guard let host = url.host() else { return nil}
        
        switch DeepLinkURLs(rawValue: host){
        case .video:
            return .menuItem(item: video)
        case .chat:
            return .menuItem(item: chat)
        case .vcl:
            return .menuItem(item: vcl)
            
       // case .product:
       //     let queryParams = url.queryParameters
       //     guard let itemQueryVal = queryParams?["item"] as? String,
                 // let product = await productFetcher.fetchProduct(by: itemQueryVal) else {return .invalidProduct(hideTabBar: true)}
                //  return .menuItem(item: product, hideTabBar: true)
        default:
            return nil
        }
    }
}
    
/* not needed if only video/chat is used
    extension URL {
        public var queryParameters: [String: String]? {
            guard
                let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true),
                let queryItems = urlComponents.queryItems else { return nil }
            return queryItems.reduce(into: [String: String]()) { (result, item) in
                result[item.name] = item.value?.replacingOccurences(of: "+", with: " ")
        }
    }
}
*/
