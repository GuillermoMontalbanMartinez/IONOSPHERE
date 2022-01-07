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
            ZStack {
                Color("Background")
                GeometryReader { geometry in
                    VStack {
                        ScrollView {
                            VStack(spacing: 20) {
                                Spacer()
                                Spacer()
                                Text("Estadísticas")
                                    .bold().font(.custom("Poppins-Regular", size: 32))
                                
                                DiagramaView()
                            }.frame(height: 650)
                        }
                    }
                }.onAppear{
                    let data = vm.getInstanciasClases()
                    
                    chartDataSet = [
                        ChartData(label: "Good", value: data["Good"] ?? 10),
                        ChartData(label: "Bad", value: data["Bad"]  ?? 11)
                    ]
                    
                }
            }.ignoresSafeArea()
        }.frame(width: UIScreen.main.bounds.width)
    }
}


/*struct HomeAdminView_Previews: PreviewProvider {
 static var previews: some View {
 HomeAdminView(mostrarInformación: true)
 }
 }*/

