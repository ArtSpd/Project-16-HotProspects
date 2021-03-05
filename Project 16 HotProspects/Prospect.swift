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
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
}
