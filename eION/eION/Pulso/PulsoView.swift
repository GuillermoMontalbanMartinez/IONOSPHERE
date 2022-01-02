//
//  PulsoView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//

import SwiftUI

struct PulsoView: View {
    var pulso: Pulso
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        
        ZStack {
                Circle().fill(Color.accentColor).frame(width: 200, height: 200).offset(x: 100, y: 100)
                Circle().fill(Color.accentColor).frame(width: 80, height: 80).offset(x: 160, y: 250)

                GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 10) {

                    HStack {
                        Text(pulso.nombrePulso ?? "").font(.custom("Poppins-Regular", size: 22)).fontWeight(.bold)
                        Image(systemName: (vm.usuarioLogeado?.guardaPulsoRelation?.contains(pulso) ?? false) ? "bookmark.fill" :  "bookmark").foregroundColor(Color.accentColor).frame(width: 100, height: 100).scaledToFit().onTapGesture {
                            vm.guardarPulsoUsuario(usuario: vm.usuarioLogeado!, pulso: pulso)
                        }
                    }
                                        
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("A03").font(.custom("Poppins-Regular", size: 18)).frame(width: 100, alignment: .leading)
                        Text("\(pulso.a03)").font(.custom("Poppins-Regular", size: 14))
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text("A27").font(.custom("Poppins-Regular", size: 18)).frame(width: 100, alignment: .leading)
                        Text("\(pulso.a27)").font(.custom("Poppins-Regular", size: 14))
                    }
                    
                    HStack(alignment: .center, spacing: 15.0) {
                        Text(NSLocalizedString("Form-clase-pulsoview-key", comment: "")).font(.custom("Poppins-Regular", size: 18)).frame(width: 100, alignment: .leading)
                        Text(pulso.clase ? "Good" : "Bad").font(.custom("Poppins-Regular", size: 14))
                    }
                    
                    HStack(alignment: .center, spacing: 10.0) {
                        Text(NSLocalizedString("Form-fecha-registro-key", comment: "")).font(.custom("Poppins-Regular", size: 18)).frame(width: 100, alignment: .leading)
                        Text(formatearFecha(pulso: pulso.fechaCreacion ?? Date())).font(.custom("Poppins-Regular", size: 14))
                    }
                    
                    if pulso.usuarioRelation?.nombre != nil  {
                        HStack {
                            Text(NSLocalizedString("Form-name-usuario-pulsoview-key", comment: "")).font(.custom("Poppins-Regular", size: 18)).frame(width: 100, alignment: .leading)
                            Text(pulso.usuarioRelation?.nombre  ?? "").font(.custom("Poppins-Regular", size: 14))
                        }
                    }
                    
                    
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/2, alignment: .center)
                    .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
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
