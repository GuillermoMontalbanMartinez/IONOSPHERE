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
    @State var tipoUsuario = true
    //
    //@EnvironmentObject var tipoUsu: ViewModel
    var body: some View {
        HStack {
            Text(tituloIzq)
            Spacer()
            if ( tituloDer != nil) {
                Text(tituloDer!).font(.caption).foregroundColor(.gray)
            }
            if(botonAdmin == true){
                
                // He pensado en algo como ->
                // variable nueva con el tipo de usuario (tipoUsu)
                // tipoUsu == 1 ? tipoUsuario = true : tipoUsuario = false
                // Crear un metodo en ViewModel donde se cambie el tipo de usuario.
                // Creo que esto se deberia hacer en la vista ListaUsuariosAdmin
                
                Toggle("", isOn: $tipoUsuario)
                
                //if(tipoUsuario){
                //    tipoUsu = 1
                //}else{
                //   tipoUsu = 2
                //}
            }

        }
            .padding()
            .frame(width: 280)
            .background(Color("FilaTabla"))
            .cornerRadius(20)
    }
}

struct FilaTablaview_Previews: PreviewProvider {
    static var previews: some View {
        FilaTablaview(tituloIzq: "Prueba", tituloDer: "Prueba")
    }
}
