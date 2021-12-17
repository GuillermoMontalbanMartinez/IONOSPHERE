//
//  MenuView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI

struct MenuView: View {
    @State var seleccion: String = ""
    @EnvironmentObject var vm : ViewModel
    @State var logout = false
    
    init() {
        UITabBar.appearance().isHidden = false
    }
    
    var body: some View {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $seleccion) {
                    HomeView().tag("Home")
                    ListadoUbicacionesView().tag("Ubicaciones")
                    ListaUsuariosAdmin().tag("Usuarios")
                    HomeAdminView().tag("HomeAdmin")
                    // LoginView().tag("CerrarSesion")
                }
                 
                
                HStack(spacing: 0) {
                    TabButton(title: vm.usuarioLogeado?.tipoUsuario == 0 ? "HomeAdmin" : "Home", image: "house", selected: $seleccion)
                    Spacer(minLength: 0)
                    TabButton(title: vm.usuarioLogeado?.tipoUsuario == 0 ? "Usuarios" : "Ubicaciones", image: "list.bullet", selected: $seleccion)
                    Spacer(minLength: 0)
                    TabButton(title: "Cerrar sesión", image: "arrow.forward.square.fill", selected: $seleccion).onTapGesture {
                        logout = true
                    }
                    
                }.padding(.vertical, 20)
                    .padding(.horizontal, 15)
                    .background(Color.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                    //.cornerRadius(20)
                    .onAppear{seleccion = vm.usuarioLogeado?.tipoUsuario == 0 ? "HomeAdmin" : "Home"}
            }.ignoresSafeArea()
        

        
    }
}
    
   // struct MenuView_Previews: PreviewProvider {
        //static var previews: some View {
         //   MenuView()
     //   }
  //  }
    
    
