//
//  HomeAdminView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI

struct HomeAdminView: View {
    
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Estadísticas")
                            .bold()
                            .font(.largeTitle)
                        
                        DiagramaView()
                        
                    }.frame(height: geometry.size.height)
                }
            }
            .padding().navigationTitle("Administrador")
        }.onAppear{
            let data = vm.getInstanciasClases()
            
            chartDataSet = [
                ChartData(label: "Good", value: data["Good"] ?? 10),
                ChartData(label: "Bad", value: data["Bad"]  ?? 11)
            ]
            
        }
    }
}


/*struct HomeAdminView_Previews: PreviewProvider {
 static var previews: some View {
 HomeAdminView(mostrarInformación: true)
 }
 }*/

