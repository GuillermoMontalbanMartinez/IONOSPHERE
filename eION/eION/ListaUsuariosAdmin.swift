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
            VStack(alignment: .center, spacing: -140) {
                
                VStack(alignment: .center, spacing:20) {
                    
                    BusquedaView(text: $text)
                    HStack(alignment: .center, spacing: 0 ){
                        Text("Usuario")
                        Spacer()
                        Text("Lector/Visitante")
                    }.padding(.init(top: 0, leading: 40, bottom: -20, trailing: 50))
                    
                    
                    
                    List(){
                        
                        ForEach(vm.usuarios){ usuario in
                            if(usuario.tipoUsuario != 0){
                                if(text.isEmpty || usuario.nombre!.hasPrefix(text)){
                                    NavigationLink(destination: ListadoUbicacionesView(destino: true)){
                                        // Probar aqui la funcion para ver si usuario.tipoUsuario = 1 o 2
                                        // y asignar el valor a tipousuario: Bool para el toogle
                                        // A filaTablaView pasarle un parámetro más que establezca el Toogle()
                                        FilaTablaview(tituloIzq: usuario.nombre!, botonAdmin: true, tipoUsuario: usuario.tipoUsuario == 1 ? true : false, nombre: usuario.nombre ?? "")
                                    }
                                }
                        }
                        }
                        .onDelete(perform: vm.deleteUsuario)
                        //Opcion de poder mover los usuario por la lista, sería añadiendo el boton de editar
                        // Mueve demasiado los elementos hacia la derecha y no queda bien con las vistas actuales.
                        //.onMove{
                        //    (IndexSet, index) in vm.usuarios.move(fromOffsets: IndexSet, toOffset: index)
                        //}
                    }
                    //Boton para la opcion de editar los elementos, opcion de mover y borrar con boton en vez de arrastrar.
                    //.navigationBarItems(trailing: EditButton())
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

/*struct ListaUsuariosAdmin_Previews: PreviewProvider {
    static var previews: some View {
        ListaUsuariosAdmin().environmentObject(ViewModel())
    }
}*/
