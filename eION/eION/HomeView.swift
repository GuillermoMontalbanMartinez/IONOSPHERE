//
//  HomeView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Image("AppLogo").resizable().frame(width: 200, height: 200, alignment: .center)
                    }.frame(width: geometry.size.width, height: geometry.size.height/2)
                    
                    Text("Bienvenido de nuevo, usuario").font(.title)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
