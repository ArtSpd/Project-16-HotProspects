//
//  Prospect.swift
//  Project 16 HotProspects
//
//  Created by Артем Волков on 05.03.2021.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Artem Volkov"
    var emailAddress = ""
    fileprivate(set)var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey){
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data){
                self.people = decoded
                return
            }
        }
        self.people = []
    }
    
   private func save(){
        if let encoded = try? JSONEncoder().encode(people){
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    func add(_ prospect: Prospect){
        people.append(prospect)
        self.save()
    }
    
    func toggle(_ prospect: Prospect){
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
