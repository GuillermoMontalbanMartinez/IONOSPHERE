//
//  PulsoView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//

import SwiftUI

struct PulsoView: View {
    @State var busqueda: String = ""
    var identificador: String
    var a03: Double
    var a27: Double
    var fechaRegistro: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 10) {
                Text(identificador).font(.title).fontWeight(.bold)
                HStack(alignment: .center, spacing: 10.0) {
                    Text("A03").fontWeight(.bold).frame(width: 100, alignment: .leading)
                    Text("\(a03)")
                }
                
                HStack(alignment: .center, spacing: 10.0) {
                    Text("A27").fontWeight(.bold).frame(width: 100, alignment: .leading)
                    Text("\(a27)")
                }
                
                HStack(alignment: .center, spacing: 10.0) {
                    Text("Fecha de registro").fontWeight(.bold).frame(width: 100, alignment: .leading)
                    Text(fechaRegistro)
                }
                
            }.frame(width: geometry.size.width/1.1, height: geometry.size.height/2, alignment: .center)
                .background(Color.white)
                .cornerRadius(30)
                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                .shadow(radius: 10)
            
        }
    }
}



struct PulsoView_Previews: PreviewProvider {
    static var previews: some View {
        PulsoView(identificador: "0001", a03: 23.5, a27: 0.5, fechaRegistro: "05/04/03")
    }
}
