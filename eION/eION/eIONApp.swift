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
    var body: some Scene {
        WindowGroup {
            RegistroView().environmentObject(vm)
        }
    }
}
