//
//  ListadoUbicacionesView.swift
//  eION
//
//  Created by Cristian on 25/11/21.
//

import SwiftUI

struct ListadoUbicacionesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var destino : Bool = false
    @State var text: String = ""
    var provincias: [String] = ["Almería", "Ávila", "Barcelona", "Zaragoza"]
    var body: some View {
        NavigationView{
            VStack{
                CustomNavigationView(title:"Ubicación", botones: false, destino: destino, anadir: .constant(false))
                VStack(alignment: .center, spacing:20) {
                    
                    BusquedaView(text: $text)
                    
                    List(){
                        
                        ForEach(provincias, id: \.self) { provincia in
                            if(text.isEmpty || provincia.hasPrefix(text)){
                                NavigationLink(destination: ListadoPulsosView(provincia: provincia)){
                                    FilaTablaview(tituloIzq: provincia)
                                }
                            }
                        }
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
               
            }.navigationBarHidden(true)
            
        }
            //.navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}

/*struct ListadoUbicacionesView_Previews: PreviewProvider {
    static var previews: some View {
        ListadoUbicacionesView()
    }
}*/
