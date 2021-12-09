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
    @State var logeado: Bool = false
    var body: some Scene {
        WindowGroup {
            if logeado {
                MenuView().environmentObject(vm)
            } else {
                LoginView(logeado: $logeado).environmentObject(vm)
            }
        }
    }
}
