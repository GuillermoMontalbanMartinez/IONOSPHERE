//
//  PulsoView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//

import SwiftUI

struct PulsoView: View {
    /*var identificador: String
    var a03: Double
    var a27: Double
    var fechaRegistro: String
    var clase: Bool*/
    
    var pulso: Pulso
    
    var body: some View {
        
        ZStack {
            BackgroundView(height: 40).padding(.top, 200)
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        Text(pulso.nombrePulso ?? "").font(.largeTitle).fontWeight(.bold)
                        Image(systemName: "bookmark").foregroundColor(Color.accentColor).frame(width: 100, height: 100).scaledToFit()
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("A03").fontWeight(.bold).frame(width: 100, alignment: .leading)
                        Text("\(pulso.a03)").font(.caption)
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("A27").fontWeight(.bold).frame(width: 100, alignment: .leading)
                        Text("\(pulso.a27)").font(.caption)
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("Clase").fontWeight(.bold).frame(width: 100, alignment: .leading)
                        Text(pulso.clase ? "Good" : "Bad").font(.caption)
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("Fecha de registro").fontWeight(.bold).frame(width: 100, alignment: .leading)
                        Text(formatearFecha(pulso: pulso.fechaCreacion ?? Date())).font(.caption)
                    }
                    
                    if pulso.usuarioRelation?.nombre != nil  {
                        HStack {
                            Text("Nombre usuario").fontWeight(.bold).frame(width: 100, alignment: .leading)
                            Text(pulso.usuarioRelation?.nombre  ?? "").font(.caption)
                        }
                    }
                    
                    
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/2, alignment: .center)
                    //.foregroundColor(.white)
                    //.background(.ultraThinMaterial)
                    //.cornerRadius(30)
                    .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                    //.shadow(radius: 10)
                
            }
        }
    }
}


func formatearFecha(pulso: Date) -> String {
    let formater = DateFormatter()
    formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let fecha = formater.string(from: pulso)
    return fecha
}


/*struct PulsoView_Previews: PreviewProvider {
    static var previews: some View {
        PulsoView(identificador: "0001", a03: 23.5, a27: 0.5, fechaRegistro: "05/04/03")
.previewInterfaceOrientation(.portrait)
    }
}*/
