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
                    ? Color("Color").opacity(0.4)
                    : Color("Color").opacity(1))
                        .padding()
                        .cornerRadius(100)
            
            TextField("Buscar…", text:$text).font(.custom("Poppins-Regular", size: 18))
        
            Button(){
                text = ""
            }label:{
                Image(systemName: "x.circle.fill").foregroundColor(Color("Color"))
            }
            .padding(.trailing)
            .opacity(text.isEmpty ? 0.0 : 0.8)
                    
            }
             .background(Color(UIColor.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
            

    }
}

/*struct BusquedaView_Previews: PreviewProvider {
    static var previews: some View {
        BusquedaView(text: .constant("Prueba"))
    }
}*/
