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
    
    init() {
        UITabBar.appearance().isHidden = false
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $seleccion) {
                HomeView().tag("Home")
                ListadoUbicacionesView().tag("Ubicaciones")
                HomeAdminView().tag("HomeAdmin")
                // LoginView().tag("CerrarSesion")
            }
            
            HStack(spacing: 0) {
                TabButton(title: vm.usuarioLogeado?.tipoUsuario == 0 ? "HomeAdmin" : "Home", image: "house.fill", selected: $seleccion)
                Spacer(minLength: 0)
                TabButton(title: "Ubicaciones", image: "note.text", selected: $seleccion)
                Spacer(minLength: 0)
                TabButton(title: "CerrarSesion", image: "arrow.backward.square.fill", selected: $seleccion)
                
            }.padding(.vertical, 15)
                .padding(.horizontal, 15)
                .background(Color.accentColor)
                .cornerRadius(20)
                .onAppear{seleccion = vm.usuarioLogeado?.tipoUsuario == 0 ? "HomeAdmin" : "Home"}
                
        }
        
    }
}
    
    struct MenuView_Previews: PreviewProvider {
        static var previews: some View {
            MenuView()
        }
    }
    
    
