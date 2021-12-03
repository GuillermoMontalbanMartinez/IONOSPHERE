//
//  HomeAdminView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI

struct HomeAdminView: View {
    let lista = [2.0, 1.0]
    let clases = ["Good", "Bad"]
    @State var tappedValue = 0
    @State var mostrarInformación = false
    var colores : [Color] = [Color("GoodClass"), Color("BadClass")]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ForEach(0..<lista.count) { index in
                        DiagramaView( lista: lista, index: index ) .foregroundColor(colores[index]).opacity(mostrarInformación ? 0 : 1)
                            .onTapGesture {
                                mostrarInformación = true
                                self.tappedValue = index
                        }
                    }
                    
                    if (mostrarInformación) {
                        ClaseInfoView(valor: lista[tappedValue], nombreClase: clases[tappedValue], index: tappedValue, lista: lista, mostrarInformación: $mostrarInformación)
                    }
                }
                
                if(!mostrarInformación) {
                    Text("Selecciona cada clase para obtener más información")
                }

            }.navigationTitle(Text("Estadísticas")).onAppear {
                mostrarInformación = false
            }
        }
    }
}

struct ClaseInfoView: View {
    let valor: Double
    let nombreClase: String
    let index: Int
    let lista : [Double]
    @Binding var mostrarInformación: Bool
    var colores : [Color] = [Color("GoodClass"), Color("BadClass")]
    @State var scale: CGFloat = 0.6
    @State var opacity: CGFloat = 0



    var body: some View {
        VStack(alignment: .leading) {
            
            DiagramaView(lista: lista, index: index).foregroundColor(colores[index]).onTapGesture {
                mostrarInformación = false
            }

            VStack(alignment: .center) {
                Text("CLASE \(nombreClase)").fontWeight(.bold)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Número de instancias:").fontWeight(.bold)
                        Text("\(String(format:"%.2f", valor))")
                    }
                }
            }
            .padding(30).foregroundColor(Color.white).background(Color.accentColor).clipShape(Capsule()).frame(width: UIScreen.main.bounds.maxX)

            
        }.padding().onAppear {
            withAnimation(.easeIn(duration: 0.4)) {
                scale += 0.4
                opacity += 1
            }
        }.scaleEffect(scale).opacity(opacity)

            
        
    }
}

struct HomeAdminView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAdminView(mostrarInformación: true)
    }
}
