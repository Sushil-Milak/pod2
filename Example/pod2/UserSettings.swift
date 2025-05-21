//
//  UserSettings.swift
//  beneproto
//
//  Created by sushil on 2/13/25.
//

import Foundation
class UserSettings: ObservableObject {
    @Published var presentEULA: Bool {
        didSet {
            UserDefaults.standard.set(presentEULA, forKey: "presentEULA")
        }
    }
    
    @Published var yourProviders = [YourProvider]() {
        didSet {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(yourProviders), forKey: "yourProviders")
        }
    }
    
    @Published var yourMedications = [YourMedication]() {
        didSet {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(yourMedications), forKey: "yourMedications")
        }
    }
    
    init() {
        self.presentEULA = UserDefaults.standard.object(forKey: "presentEULA") as? Bool ?? true
        
        if let providerData = UserDefaults.standard.value(forKey: "yourProviders") as? Data {
            if let userDefaultYourProviders = try? PropertyListDecoder().decode(Array<YourProvider>.self, from: providerData){
                yourProviders = userDefaultYourProviders
            }
        }
        
        if let medicationsData = UserDefaults.standard.value(forKey: "yourMedications") as? Data {
            if let userDefaultYourMedications = try? PropertyListDecoder().decode(Array<YourMedication>.self, from: medicationsData){
                yourMedications = userDefaultYourMedications
            }
        }
        
//        self.yourProviders = UserDefaults.standard.object(forKey: "yourProviders") as? [YourProvider] ?? []
//        self.yourMedications = UserDefaults.standard.object(forKey: "yourMedications") as? [YourMedication] ?? []
    }
}

struct YourProvider: Identifiable, Codable {
    var id = UUID()
    var firstName, lastName, company, address, city, stateTerritory, zipCode, phoneNumber, faxNumber, selectedContactType: String
    
    init(firstName:String,
         lastName:String,
         company:String,
         address:String,
         city:String,
         stateTerritory:String,
         zipCode:String,
         phoneNumber:String,
         faxNumber:String
         , selectedContactType: String){
        
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.address = address
        self.city = city
        self.stateTerritory = stateTerritory
        self.zipCode = zipCode
        self.phoneNumber = phoneNumber
        self.faxNumber = faxNumber
        self.selectedContactType = selectedContactType
    }
}

struct YourMedication: Identifiable, Codable {
    var id = UUID()
    var medicationName, medicationDose, medicationFrequency: String
    
    init(medicationName: String, medicationDose: String, medicationFrequency:String){
        self.medicationName = medicationName
        self.medicationDose = medicationDose
        self.medicationFrequency = medicationFrequency
    }
}
