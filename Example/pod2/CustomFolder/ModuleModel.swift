//
//  RoomModel.swift
//  voice_video_version1
//
//  sushil. Need model
//
import Foundation



protocol MenuItem {
    var id: String { get }
    var name: String { get }
    var integerValue: Int { get }
}


struct Video: Identifiable, Hashable, MenuItem {
    var id: String
    let integerValue: Int
    let name: String
    init(integerValue: Int, name: String) {
            self.id = UUID().uuidString
            self.integerValue = integerValue
            self.name = name
        }
    
}

struct Chat: Identifiable, Hashable, MenuItem {
    var id: String
    let integerValue: Int
    let name: String
    init(integerValue: Int, name: String) {
            self.id = UUID().uuidString
            self.integerValue = integerValue
            self.name = name
        }
    
}
struct Vcl_module: Identifiable, Hashable, MenuItem {
    var id: String
    let integerValue: Int
    let name: String
    init(integerValue: Int, name: String) {
            self.id = UUID().uuidString
            self.integerValue = integerValue
            self.name = name
        }
    
}
struct FMPSessionLaunchModel: Identifiable, Hashable, MenuItem {
    var id: String
    let integerValue: Int
    let name: String
    init(integerValue: Int, name: String) {
            self.id = UUID().uuidString
            self.integerValue = integerValue
            self.name = name
        }
    
}

//let video : [Video] = [Video(integerValue: 1, name: "CSR-Video")]
let video : Video = Video(integerValue: 1, name: "CHAMPVA")
let vv = video
let chat : Chat = Chat(integerValue: 1, name: "FMP")
let vcl : Vcl_module = Vcl_module(integerValue: 1, name: "VCL")








