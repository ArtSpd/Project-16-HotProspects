//
//  MeView.swift
//  Project 16 HotProspects
//
//  Created by Артем Волков on 05.03.2021.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    
    @State var name = "Anonumous"
    @State var emailAddress = "example@ex.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)
                TextField("Email Addres", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])
                Image(uiImage: generateCode(from: "\(name)\n\(emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                
            }
            .navigationBarTitle("Your code ")
        }
    }
    func generateCode(from srting: String)-> UIImage{
        let data = Data(srting.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage{
            if let cgImg = context.createCGImage(outputImage, from: outputImage.extent){
                return UIImage(cgImage: cgImg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
