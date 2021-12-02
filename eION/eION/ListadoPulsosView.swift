//
//  ListadoPulsos.swift
//  eION
//
//  Created by Cristian Casado on 1/12/21.
//

import SwiftUI
import MapKit

struct ListadoPulsosView: View {
    @EnvironmentObject var vm : ViewModel
    @State var text: String = ""
    @State var mostrarFiltro: Bool = false
    //var provincia : String
    var latitud: Double = 0.0
    var longitud: Double = 0.0
    @State private var region = MKCoordinateRegion()
    init(provincia : String){
        switch(provincia){
        case "Almería":
            latitud = 36.8402
            longitud = -2.46792
            break
        case "Ávila":
            latitud = 40.6564
            longitud = -4.70032
            break
        case "Barcelona":
            latitud = 41.3879
            longitud = 2.16992
            break
        case "Zaragoza":
            latitud = 41.6563
            longitud = -0.876566
            break
        default:
            latitud = 0.0
            longitud = 0.0
        }
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: -140) {
                VStack{
                    Map(coordinateRegion: $region)
                        .onAppear(){
                            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitud,
                                longitude: longitud),
                                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                            )
                        }
                            .frame(width: 400, height: 150, alignment: .center)
                }
                
                VStack(alignment: .center, spacing:20) {
                    HStack{
                        BusquedaView(text: $text)
                            .padding(.leading, 60)
                        Button(){
                            mostrarFiltro.toggle()
                        }label:{
                            Image(systemName: "chevron.up.chevron.down")
                                .resizable()
                                .frame(width: 70, height: 40)
                                .foregroundColor(Color.accentColor)
                                .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
                        }
                            .padding(.bottom, 63)
                    }
                    
                    List(){
                        
                        ForEach(vm.pulsos) { pulso in
                            if(text.isEmpty || pulso.nombrePulso!.hasPrefix(text)){
                            NavigationLink(destination: PulsoView(identificador: pulso.nombrePulso!, a03: pulso.a03, a27: pulso.a27, fechaRegistro: formatearFecha(pulso: pulso.fechaCreacion ?? Date()))) {
                                FilaTablaview(tituloIzq: pulso.nombrePulso!, tituloDer: formatearFecha(pulso: pulso.fechaCreacion ?? Date()))
                                }
                            }
                        }
                            .onDelete{ indexSet in
                                vm.pulsos.remove(atOffsets: indexSet)
                            }
                            
                    }
                        .scaledToFit()
                        .onAppear() {
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
                                .foregroundColor(Color.accentColor)
                                .padding(.top, 100)
                        }
                )
                .sheet(isPresented: $mostrarFiltro){
                    //FiltroView
                }
                
        }
    }
}

func formatearFecha(pulso: Date) -> String {
    let formater = DateFormatter()
    formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let fecha = formater.string(from: pulso)
    return fecha
}

struct ListadoPulsos_Previews: PreviewProvider {
    static var previews: some View {
        ListadoPulsosView(provincia: "Almería")
            .environmentObject(ViewModel())
    }
}
