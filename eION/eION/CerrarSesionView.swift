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
            }
            
        }
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
                Image(systemName: "lock.fill")
                    .resizable()
                    .frame(width: 30, height: 50, alignment: .center)
                    .offset(y:10)
                    .foregroundColor(.black)
                Text("¿Desea cerrar sesión?")
                    .bold()
                    .offset(y: 10)
                HStack {
                    Button {
                    
                    } label: {
                        Label("Confirmar", systemImage: "checkmark.rectangle.fill").foregroundColor(.green)
                    }.buttonStyle(.bordered)
                    
                    Button {
                        
                    } label: {
                        Label("Cancelar", systemImage: "xmark.circle.fill").foregroundColor(.red)
                    }.buttonStyle(.bordered)
                }.padding()
                 .offset(y:-10)
            }.scaledToFill()
             .frame(width: 300, height: 300)
             .cornerRadius(20)
             .background(BackgroundView(height: 3))
             .background(.ultraThinMaterial)
             .offset(y:-70)
        }
    }
}
