//
//  ListadoPulsos.swift
//  eION
//
//  Created by Cristian Casado on 1/12/21.
//

import SwiftUI
import MapKit

struct ListadoPulsosView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var vm : ViewModel
    @State var text: String = ""
    @State var mostrarFiltro: Bool = false
    @State var anadir : Bool = false
    var latitud: Double = 0.0
    var longitud: Double = 0.0
    var provincia: Provincia
    var usuario: String
    @State var filtroNombre: Bool = false
    @State var filtroFecha: Bool = false
    
    @State private var region = MKCoordinateRegion()
    init(provincia : Provincia, usuario: String){
        self.provincia = provincia
        self.usuario = usuario
        switch(provincia.nombre){
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
    
    @State var selection = ""
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    CustomNavigationView(title: "Pulsos", botones: vm.usuarioLogeado?.tipoUsuario == 1, destino: true, anadir: $anadir).zIndex(1).offset(y: 100)
                    Map(coordinateRegion: $region)
                        .onAppear(){
                            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitud,
                                                                                       longitude: longitud),
                                                        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                            )
                        }.ignoresSafeArea()
                        .frame(width: 400, height: 250)
                        
                                        
                    VStack(alignment: .center, spacing:0) {
                        HStack{
                            BusquedaView(text: $text).frame(width: 250)
                            Button(){
                                mostrarFiltro.toggle()
                            }label:{
                                Image(systemName: "chevron.up.chevron.down")
                                    .frame(width: 70, height: 40)
                                    .background(Color.accentColor)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous))
                            }
                        }
                        
                        List(){
                            ForEach(vm.pulsos.filter({($0.ubicacion == provincia.nombre && usuario.isEmpty) || ($0.ubicacion == provincia.nombre && $0.usuarioRelation?.nombre == usuario)}).sorted() {
                                    if(filtroNombre){
                                        return $0.nombrePulso! < $1.nombrePulso!
                                    }else if (filtroFecha){
                                        return $0.fechaCreacion! < $1.fechaCreacion!
                                    } else{
                                        return $0.nombrePulso! < $1.nombrePulso!
                                    }
                                } ) { pulso in
                                if(text.isEmpty || pulso.nombrePulso!.hasPrefix(text)){
                                    NavigationLink(destination: PulsoView(pulso: pulso).environmentObject(vm)) {
                                        FilaTablaview(tituloIzq: pulso.nombrePulso!, tituloDer: formatearFecha(pulso: pulso.fechaCreacion ?? Date()), tipoUsuario: true)
                                    }.listRowInsets(EdgeInsets()).padding().listRowSeparator(.hidden)
                                }
                            }
                        }
                        .scaledToFit()
                        .onAppear() {
                            UITableView.appearance().backgroundColor = .clear
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height*0.70, alignment: .center)
                    .background(Color.white)
                    
                    Spacer()
                }.frame(height: geometry.size.height)
                    .background(
                        NavigationLink("", destination: CrearPulsoView(ubicacion: provincia.nombre), isActive: $anadir)
                    )
                    .confirmationDialog("Seleccione un filtro", isPresented: $mostrarFiltro, titleVisibility: .visible) {
                        Button("Ordenar por nombre") {
                            filtroNombre.toggle()
                        }
                        
                        Button("Ordenar por fecha") {
                            filtroFecha.toggle()
                        }
                    }
                    .navigationBarHidden(true)
            }
        }
    }
}

/*struct ListadoPulsos_Previews: PreviewProvider {
 static var previews: some View {
 ListadoPulsosView(provincia: "Almería")
 .environmentObject(ViewModel())
 }
 }
*/
