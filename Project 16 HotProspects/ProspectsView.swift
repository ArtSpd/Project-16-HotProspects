//
//  ProspectsView.swift
//  Project 16 HotProspects
//
//  Created by Артем Волков on 05.03.2021.
//

import SwiftUI

struct ProspectsView: View {
    
    enum FilterTupe{
        case none, contacted, uncontacted
    }
    
    let filter: FilterTupe
    @EnvironmentObject var prospects: Prospects
    
    var title: String{
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted"
        }
    }
    
    var filterdProspects: [Prospect]{
        switch filter{
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter{ $0.isContacted}
        case .uncontacted:
            return prospects.people.filter{!$0.isContacted}
        }
    }
    var body: some View {
        NavigationView{
            List{
                ForEach(filterdProspects){ prospect in
                    VStack(alignment: .leading){
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
                .navigationBarTitle(title)
                .navigationBarItems(trailing: Button(action: {
                    let prospect = Prospect()
                    prospect.name = "Artem Volkov"
                    prospect.emailAddress = "example@example.com"
                    self.prospects.people.append(prospect)
                }, label: {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }))
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
