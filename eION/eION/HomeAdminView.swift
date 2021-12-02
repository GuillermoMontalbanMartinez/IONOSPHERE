//
//  HomeAdminView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI

struct HomeAdminView: View {
    let lista = [1.0, 2.0]
    let clases = ["Good", "Bad"]
    @State var chosenColors: [Color] = []
    @State var tappedValue = 0
    @State var mostrarInformación = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ForEach(0..<lista.count) { index in
                        DiagramaView( lista: lista, index: index, className: clases[index] ).foregroundColor(Color(generateRandomColor())).onTapGesture {
                            mostrarInformación = true
                            self.tappedValue = index
                        }
                    }
                }
                
                if (mostrarInformación) {
                    ClaseInfoView(valor: lista[tappedValue], nombreClase: clases[tappedValue])
                }
                
            }.navigationTitle(Text("Estadísticas"))
        }
    }
}

struct ClaseInfoView: View {
    let valor: Double
    let nombreClase: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Nombre de la clase:").fontWeight(.bold)
                Text("\(nombreClase)")
            }
            HStack {
                Text("Número de instancias:").fontWeight(.bold)
                Text("\(String(format:"%.2f", valor))")
            }
            
        }.padding().background(Color("FilaTabla")).clipShape(Capsule())
        
    }
}

func generateRandomColor() -> UIColor {
    return UIColor.random()
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(in: 0...1),
            green: .random(in: 0...1),
            blue:  .random(in: 0...1),
            alpha: 0.5
        )
    }
}



struct HomeAdminView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAdminView(mostrarInformación: true)
    }
}
