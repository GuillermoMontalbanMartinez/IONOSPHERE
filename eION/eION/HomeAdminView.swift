//
//  HomeAdminView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI

struct HomeAdminView: View {
    let lista = [1.0, 2.0, 3.0, 3.0, 4.0 ,5.0, 1.0]
    
    let colors = [
        Color(red: 126/255, green: 40/255, blue: 80/255),
        Color(red: 49/255, green: 63/255, blue: 95/255),
        Color(red: 37/255, green: 166/255, blue: 188/255),
        Color(red: 130/255, green: 122/255, blue: 162/255),
        Color(red: 241/255, green: 165/255, blue: 138/255)
    ]

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ForEach(0..<lista.count) { index in
                        DiagramaView( lista: lista, index: index ).foregroundColor(Color(generateRandomColor()))
                    }
                }
            }.navigationTitle(Text("Estadísticas"))
        }

    }
}

func generateRandomColor() -> UIColor {
    let redValue = CGFloat(drand48())
    let greenValue = CGFloat(drand48())
    let blueValue = CGFloat(drand48())
        
    let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
    return randomColor
    }

struct HomeAdminView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAdminView()
    }
}
