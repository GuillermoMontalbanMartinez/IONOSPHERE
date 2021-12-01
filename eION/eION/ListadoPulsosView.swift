//
//  ListadoPulsos.swift
//  eION
//
//  Created by Cristian Casado on 1/12/21.
//

import SwiftUI

struct ListadoPulsosView: View {
    @EnvironmentObject var vm : ViewModel
    @State var text: String = ""
    @State var mostrarFiltro: Bool = false
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: -140) {
                
                VStack(alignment: .center, spacing:20) {
                    HStack{
                        BusquedaView(text: $text)
                            .padding(.leading, 60)
                        Button(){
                            mostrarFiltro.toggle()
                        }label:{
                            Image(systemName: "plus.rectangle.fill")
                                .resizable()
                                .frame(width: 70, height: 40)
                                .foregroundColor(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
                        }
                            .padding(.bottom, 63)
                    }
                    
                    List(){
                        /*ForEach(vm.pulsos){pulso in
                            if(text.isEmpty || pulso.hasPrefix(text)){
                                NavigationLink(destination: PulsoView(identificador: pulso.nombrePulso, a03: pulso.a03, a27: pulso.a27, fechaRegistro: pulso.fechaRegistro)){
                                    FilaTablaview(tituloIzq: pulso.nombrePulso, tituloDer: pulso.fechaRegistro)
                                }
                            }
                        }
                            .onDelete{ indexSet in
                                vm.pulsos.remove(atOffsets: indexSet)
                            }*/
                    }
                        .scaledToFit()
                        .onAppear(){
                            UITableView.appearance().backgroundColor = .clear
                        }
                }
                    .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height*0.70, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 10)
               
            }
                .navigationTitle("Tus Pulsos")
                .navigationBarItems(
                    trailing:
                        NavigationLink(destination: CrearPulsoView()){
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                                .padding(.top, 100)
                        }
                )
                .sheet(isPresented: $mostrarFiltro){
                    //FiltroView
                }
        }
    }
}

struct ListadoPulsos_Previews: PreviewProvider {
    static var previews: some View {
        ListadoPulsosView()
    }
}
