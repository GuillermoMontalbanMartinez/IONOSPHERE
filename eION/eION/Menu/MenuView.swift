//
//  MenuView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//
import SwiftUI

struct MenuView: View {
    @EnvironmentObject var vm : ViewModel
    @State var logout = false
    
    init() {
        UITabBar.appearance().isHidden = false
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $vm.seleccion) {
                HomeView().tag("Home").transition(.opacity.animation(.default))
                ListadoUbicacionesView().tag("Ubicaciones").transition(.opacity.animation(.default))
                ListaUsuariosAdmin().tag("Usuarios").transition(.opacity.animation(.default))
                HomeAdminView().tag("HomeAdmin").transition(.opacity.animation(.default))
                if ( vm.usuarioLogeado?.tipoUsuario != 0 ) {
                    EditarPerfilView().tag("EditarPerfil").transition(.opacity.animation(.default))
                }
            }.environmentObject(vm)
            
            
            HStack(spacing: 0) {
                if ( vm.usuarioLogeado?.tipoUsuario == 0 ) {
                    TabButton(title: "HomeAdmin", image: "house", selected: $vm.seleccion, logout: $logout)
                    Spacer(minLength: 0)
                    TabButton(title: "Usuarios", image: "list.bullet.rectangle", selected: $vm.seleccion, logout: $logout)
                } else {
                    TabButton(title: "Home", image: "house", selected: $vm.seleccion, logout: $logout)
                    Spacer(minLength: 0)
                    TabButton(title: "Ubicaciones", image: "list.bullet.rectangle", selected: $vm.seleccion, logout: $logout)
                    Spacer(minLength: 0)
                    TabButton(title: "EditarPerfil", image: "person", selected: $vm.seleccion, logout: $logout)

                }
                
                Spacer(minLength: 0)
                TabButton(title: "Cerrar sesión", image: "arrow.forward.square", selected: $vm.seleccion, logout: $logout)
                
            }.alert(isPresented: $logout) {
                Alert(
                    title: Text("Cerrar sesión"),
                    message: Text("¿Desea cerrar sesión?"),
                    primaryButton: .destructive(Text("Cerrar sesión")) {
                        // Acciones a realizar cuando se cierra sesion
                        vm.logeado = false
                        vm.usuarioLogeado = nil
                        vm.loginActive = false
                        vm.nombreUsuarioActivo = nil
                        // print("PRUEBA: \(vm.usuarioLogeado)")
                    },
                    secondaryButton: .cancel()
                )
                
                
            }.ignoresSafeArea().padding(.vertical, 20)
                .padding(.horizontal, 20)
                //.background(Capsule().fill(Color.white))
                .background(Color("Background"))
                .zIndex(100000)
        }.ignoresSafeArea()
    }
}

/*struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(ViewModel())
    }
}*/


