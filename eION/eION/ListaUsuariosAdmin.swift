//
//  ListaUsuariosAdmin.swift
//  eION
//
//  Created by Hunor Moriczi on 25/11/21.
//

import SwiftUI

struct ListaUsuariosAdmin: View {
    @State var text: String = ""
    @State var usuarios: [String] = ["Hunor","Guillermo","Marta","Cristian","Jorge","Francisco","Luis","Ramón","Manel"]
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: -140) {
                
                VStack(alignment: .center, spacing:20) {
                    
                    BusquedaView(text: $text)
                    HStack(alignment: .center, spacing: 0 ){
                        Text("Usuario")
                        Spacer()
                        Text("Lector/Visitante")
                    }.padding(.init(top: 0, leading: 40, bottom: -20, trailing: 50))
                    
                    
                    
                    List(){
                        ForEach(usuarios, id: \.self) { usuario in
                            if(text.isEmpty || usuario.hasPrefix(text)){
                                NavigationLink(destination: ListadoPulsosView()){
                                    FilaTablaview(tituloIzq: usuario, botonAdmin: true)
                                }
                            }
                        }
                        .onDelete{
                            IndexSet in usuarios.remove(atOffsets: IndexSet)
                        }
                        //Opcion de poder mover los usuario por la lista
                        //.onMove{
                        //   (IndexSet, index) in usuarios.move(fromOffsets: IndexSet, toOffset: index)
                        //}
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
            .navigationTitle("Usuarios")
            
        }
    }
}

struct ListaUsuariosAdmin_Previews: PreviewProvider {
    static var previews: some View {
        ListaUsuariosAdmin()
    }
}
