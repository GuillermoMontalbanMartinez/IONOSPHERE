//
//  PulsoView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//

import SwiftUI

struct PulsoView: View {
    var identificador: String
    var a03: Double
    var a27: Double
    var fechaRegistro: String
    var clase: Bool
    
    var body: some View {
        
        ZStack {
            BackgroundView(height: 40).padding(.top, 200)
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        Text(identificador).font(.largeTitle).fontWeight(.bold)
                        Image(systemName: "bookmark").foregroundColor(Color.accentColor).frame(width: 100, height: 100).scaledToFit()
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("A03").fontWeight(.bold).frame(width: 100, alignment: .leading)
                        Text("\(a03)").font(.caption)
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("A27").fontWeight(.bold).frame(width: 100, alignment: .leading)
                        Text("\(a27)").font(.caption)
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("Clase").fontWeight(.bold).frame(width: 100, alignment: .leading)
                        Text(clase ? "Good" : "Bad").font(.caption)
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("Fecha de registro").fontWeight(.bold).frame(width: 100, alignment: .leading)
                        Text(fechaRegistro).font(.caption)
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



/*struct PulsoView_Previews: PreviewProvider {
    static var previews: some View {
        PulsoView(identificador: "0001", a03: 23.5, a27: 0.5, fechaRegistro: "05/04/03")
.previewInterfaceOrientation(.portrait)
    }
}*/
