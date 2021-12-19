//
//  BusquedaView.swift
//  eION
//
//  Created by Cristian on 25/11/21.
//

import SwiftUI

struct BusquedaView: View {
    @Binding var text : String
    var body: some View {
            
                HStack{
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(text.isEmpty
                                          ? Color(UIColor.gray).opacity(0.4)
                                          : Color(UIColor.gray).opacity(1))
                        .padding()
                        .cornerRadius(100)
                    
                    TextField("Buscar…", text:$text)
                    
                    Button(){
                        text = ""
                    }label:{
                        Image(systemName: "x.circle.fill")
                    }
                        .padding(.trailing)
                        .opacity(text.isEmpty ? 0.0 : 0.8)
                    
                }
                    .frame(width: 250.0, height: 40.0, alignment: .leading)
                    .background(Color(UIColor.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
                    //.shadow(color: .black, radius: 0.1, x: 0, y: 0)
                    .padding(.leading,-60)
                    .padding(.top, -50)
                


        
    }
}

struct BusquedaView_Previews: PreviewProvider {
    static var previews: some View {
        BusquedaView(text: .constant("Prueba"))
    }
}
