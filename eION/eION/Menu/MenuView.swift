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
                    HomeView().tag("Home").transition(.opacity.animation(.default))
                    ListadoUbicacionesView().tag("Ubicaciones").transition(.opacity.animation(.default))
                    ListaUsuariosAdmin().tag("Usuarios").transition(.opacity.animation(.default))
                    HomeAdminView().tag("HomeAdmin").transition(.opacity.animation(.default))
                    // LoginView().tag("CerrarSesion")
                    
                    EditarPerfilView().tag("EditarPerfil").transition(.opacity.animation(.default))
                }
                 
                
                HStack(spacing: 0) {
                    TabButton(title: vm.usuarioLogeado?.tipoUsuario == 0 ? "HomeAdmin" : "Home", image: "house", selected: $seleccion, logout: $logout)
                    Spacer(minLength: 0)
                    TabButton(title: vm.usuarioLogeado?.tipoUsuario == 0 ? "Usuarios" : "Ubicaciones", image: "list.bullet", selected: $seleccion, logout: $logout)
                    Spacer(minLength: 0)
                    TabButton(title: "EditarPerfil", image: "person.fill", selected: $seleccion, logout: $logout)
                    Spacer(minLength: 0)
                    TabButton(title: "Cerrar sesión", image: "arrow.forward.square.fill", selected: $seleccion, logout: $logout)
                    
                }.alert(isPresented: $logout) {
                    Alert(
                        title: Text("Cerrar sesión"),
                        message: Text("¿Desea cerrar sesión?"),
                        primaryButton: .destructive(Text("Cerrar sesión")) {
                            // Acciones a realizar cuando se cierra sesion
                            vm.logeado = false
                            vm.usuarioLogeado = nil
                        },
                        secondaryButton: .cancel()
                    )
                    
                    
                }.ignoresSafeArea().padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(.regularMaterial)
                    .onAppear{seleccion = vm.usuarioLogeado?.tipoUsuario == 0 ? "HomeAdmin" : "Home"}
            }.ignoresSafeArea()
        

        
    }
}
    
    struct MenuView_Previews: PreviewProvider {
        static var previews: some View {
            MenuView().environmentObject(ViewModel())
        }
    }
    
    
