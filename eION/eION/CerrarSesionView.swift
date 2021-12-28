//
//  CerrarSesionView.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 27/12/21.
//

import SwiftUI

struct CerrarSesionView: View {
    var body: some View {
        VStack {
            VStack {
                FormCerrarSesion()
            }.background(.blue)
            
        }.background(.blue)
        
    }
}

struct CerrarSesionView_Previews: PreviewProvider {
    static var previews: some View {
        CerrarSesionView()
    }
}


private struct FormCerrarSesion: View {
    @EnvironmentObject var vm : ViewModel
    
    
    var body: some View {
        NavigationView {
            VStack {
                Image("lock")
                    .resizable()
                    .frame(width: 125, height: 125, alignment: .center)
                Text("¿Desea cerrar sesión?")
                    .bold()
                HStack {
                    Button {
                    
                    } label: {
                        Label("Confirmar", image: "checkmark.rectangle.fill")
                    }
                    
                    Button {
                        
                    } label: {
                        Label("Cancelar", image: "xmark.circle.fill")
                    }
                    
                }
            }.background(.white)
                .cornerRadius(20)
                .padding([.leading, .trailing])
                .offset(y: -100)
                .frame(width: 250, height: 250, alignment: .center)
            
        }
    }
}
