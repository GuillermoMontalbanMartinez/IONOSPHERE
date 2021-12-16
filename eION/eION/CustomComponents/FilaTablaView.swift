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
                    .onChange(of: tipoUsuario){Value in
                       
                        //vm.usuarios.first(where: {$0.nombre == nombre})?.tipoUsuario = tipoUsuario ? 1 : 2
                        vm.cambiarTipo(nombre: nombre!)
                    }
                    
            
                
                
                
            }

        }
            .padding()
            .frame(width: 280)
            .background(Color("FilaTabla"))
            .cornerRadius(20)
    }
}

/*struct FilaTablaview_Previews: PreviewProvider {
    static var previews: some View {
        FilaTablaview(tituloIzq: "Prueba", tituloDer: "Prueba")
    }
}*/
