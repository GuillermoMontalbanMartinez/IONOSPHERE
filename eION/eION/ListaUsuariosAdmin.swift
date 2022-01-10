//
//  ListaUsuariosAdmin.swift
//  eION
//
//  Created by Hunor Moriczi on 25/11/21.
//

import SwiftUI

struct ListaUsuariosAdmin: View {
    @State var text: String = ""
    @EnvironmentObject var vm : ViewModel
    
    
    var body: some View {
        
        NavigationView{
            ZStack {
                Color("Background")
                VStack(alignment: .center, spacing:20) {
                    //Spacer()
                    ScrollView {
                        VStack(spacing: 30) {
                            CustomNavigationView(title:"Usuarios", botones: false, destino: false, anadir: .constant(false))

                            HStack {
                                BusquedaView(text: $text).frame(width: UIScreen.main.bounds.width-50)
                            }
                            Spacer()
                            HStack(alignment: .center, spacing: 0 ){
                                Text("Usuario").font(.custom("Poppins-Regular", size: 16))
                                Spacer()
                                Text("Lector/Visitante").font(.custom("Poppins-Regular", size: 16))
                            }.padding(.init(top: 0, leading: 40, bottom: -20, trailing: 50))
                            
                            List(){
                                ForEach(vm.usuarios){ usuario in
                                    if(usuario.tipoUsuario != 0){
                                        if(text.isEmpty || usuario.nombre!.hasPrefix(text)){
                                            NavigationLink(destination: ListadoUbicacionesView(destino: true, usuario: usuario.nombre ?? "")){
                                                FilaTablaview(tituloIzq: usuario.nombre!, botonAdmin: true, tipoUsuario: usuario.tipoUsuario == 1 ? true : false, nombre: usuario.nombre ?? "")
                                            }
                                        }
                                    }
                                }
                                .onDelete(perform: vm.deleteUsuario)
                            }
                            .scaledToFit()
                            .onAppear() {
                                UITableView.appearance().backgroundColor = .clear
                            }
                        }
                    }.frame(height: 700)
                }
                .cornerRadius(30)
                //.shadow(radius: 10)
            }.ignoresSafeArea().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center).padding()
                //.navigationTitle(Text("Usuarios").font(.custom("Poppins-Regular", size: 32)))

        }
    }
}

/*struct ListaUsuariosAdmin_Previews: PreviewProvider {
 static var previews: some View {
 ListaUsuariosAdmin().environmentObject(ViewModel())
 }
 }*/
