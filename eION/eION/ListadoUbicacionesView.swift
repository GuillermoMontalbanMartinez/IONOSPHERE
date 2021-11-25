//
//  ListadoUbicacionesView.swift
//  eION
//
//  Created by Cristian on 25/11/21.
//

import SwiftUI

struct ListadoUbicacionesView: View {
    @State var text: String = ""
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: -140) {
                
                VStack(alignment: .center, spacing:20) {
                    
                    BusquedaView(text: $text)
                    
                    List(){
                        FilaTablaview(tituloIzq: "Provincia 1")
                        FilaTablaview(tituloIzq: "Provincia 2")
                        FilaTablaview(tituloIzq: "Provincia 3")
                        FilaTablaview(tituloIzq: "Provincia 4")
                        FilaTablaview(tituloIzq: "Provincia 5")
                        FilaTablaview(tituloIzq: "Provincia 1")
                        FilaTablaview(tituloIzq: "Provincia 2")
                        FilaTablaview(tituloIzq: "Provincia 3")
                        FilaTablaview(tituloIzq: "Provincia 4")
                    }
                        .scaledToFit()
                        .onAppear(){
                            UITableView.appearance().backgroundColor = .clear
                        }
                }
                .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height*0.70, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)
               
            }
                .navigationTitle("Ubicación")
            
        }
    }
}

struct ListadoUbicacionesView_Previews: PreviewProvider {
    static var previews: some View {
        ListadoUbicacionesView(text: "")
    }
}
