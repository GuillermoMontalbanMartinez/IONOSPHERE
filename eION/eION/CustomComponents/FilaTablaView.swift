//
//  FilaTablaview.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//

import SwiftUI

struct FilaTablaview: View {
    var tituloIzq: String
    var tituloDer: String? //Puede no existir
    var botonAdmin: Bool? // True para incluir boton en vista Administrador
    @State var tipoUsuario: Bool
    var nombre: String?
    //
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        
        HStack {
            Text(tituloIzq).font(.custom("Poppins-Regular", size: 16))
            Spacer()
            if ( tituloDer != nil) {
                Text(tituloDer!).font(.custom("Poppins-Regular", size: 14)).foregroundColor(.gray)
            }
            if(botonAdmin == true){
                Toggle("", isOn: $tipoUsuario)
                    .onChange(of: tipoUsuario){Value in
                        vm.cambiarTipo(nombre: nombre!)
                    }
            }
        }
        .padding(.top, 20)
        .padding(.bottom, 20)
        .padding(.leading, 20)
        .padding(.trailing, 20)
        .frame(width: 280)
        .background(Color("Secondary"))
        .cornerRadius(10)
        
        
        
    }
}

/*struct FilaTablaview_Previews: PreviewProvider {
 static var previews: some View {
 FilaTablaview(tituloIzq: "Prueba", tituloDer: "Prueba")
 }
 }*/
