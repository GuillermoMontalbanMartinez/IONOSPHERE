//
//  eIONApp.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 18/11/21.
//

import SwiftUI

@main
struct eIONApp: App {
    @StateObject private var vm: ViewModel = ViewModel()
    // @State var logeado: Bool = false -> Ahora esta en ViewModel para que varias vistas puedan acceder a el
    var body: some Scene {
        WindowGroup {
            VStack {
                if ((vm.loginActive ?? false) || vm.logeado) {
                    MenuView().environmentObject(vm)
                } else {
                    LoginView(logeado: $vm.logeado).environmentObject(vm)
                }
            }
        }
    }
}
