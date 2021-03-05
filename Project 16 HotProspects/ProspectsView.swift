//
//  ProspectsView.swift
//  Project 16 HotProspects
//
//  Created by Артем Волков on 05.03.2021.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {
    
    enum FilterTupe{
        case none, contacted, uncontacted
    }
    
    let filter: FilterTupe
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    
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
                    }.contextMenu{
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted"){
                            self.prospects.toggle(prospect)
                        }
                    }
                }
            }
                .navigationBarTitle(title)
                .navigationBarItems(trailing: Button(action: {
                    self.isShowingScanner = true
                    
                }, label: {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }))
            .sheet(isPresented: $isShowingScanner){
                CodeScannerView(codeTypes: [.qr],simulatedData: "Artem Volkov\nartemvolk@mail.ru", completion: self.handleScane)
            }
        }
    }
    func handleScane(result: Result<String, CodeScannerView.ScanError>){
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            self.prospects.people.append(person)
            
        case .failure(let error):
            print("Scanning failde")
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
