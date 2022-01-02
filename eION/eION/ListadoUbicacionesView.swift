//
//  ListadoUbicacionesView.swift
//  eION
//
//  Created by Cristian on 25/11/21.
//

import SwiftUI

struct ListadoUbicacionesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var destino : Bool = false
    @State var text: String = ""
    var usuario: String = ""
    
    var body: some View {
        
        if(destino) {
            Content(destino: destino, text: $text, usuario: usuario)
        } else {
            NavigationView{
                Content(destino: destino, text: $text, usuario: usuario)
            }
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
            .navigationBarHidden(true)
            
        }
        
        
    }
    
    
}

struct Content: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var destino : Bool = false
    @Binding var text: String
    var provincias: [String] = ["Almería", "Ávila", "Barcelona", "Zaragoza"]
    var usuario: String = ""
    @EnvironmentObject var vm : ViewModel
    var columns: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                BackgroundView(height: 50)
                ScrollView {
                    VStack{
                        CustomNavigationView(title:"Ubicación", botones: false, destino: destino, anadir: .constant(false))

                        VStack(alignment: .center, spacing:10) {
                            BusquedaView(text: $text).frame(width: 300, height: 100, alignment: .center)
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(0..<provincias.count ) { index in
                                    if(text.isEmpty || provincias[index].hasPrefix(text)){
                                        NavigationLink(destination: ListadoPulsosView(provincia: provincias[index], usuario: usuario )){
                                            //FilaTablaview(tituloIzq: provincia, tipoUsuario: true)
                                            VStack(alignment: .leading) {
                                                Text(provincias[index]).font(.custom("Poppins-Regular", size: 18)).foregroundColor(.black).fontWeight(.bold)
                                                Image("barcelona").resizable().frame(width: 100, height: 100)
                                            }.padding().frame(width: 150, height: 150).background(.white).cornerRadius(30)
                                        }
                                    }
                                }
                            }.padding().background(.thinMaterial).cornerRadius(20)
                                .onAppear(){
                                    UITableView.appearance().backgroundColor = .clear
                                    UITableViewCell.appearance().backgroundColor = .blue
                                }
                            
                            Spacer()

                        }
                        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height*0.70, alignment: .center).padding(.top, 50)
                        .cornerRadius(30)
                    }.navigationBarHidden(true).frame(height: geometry.size.height)
                }
            }
        }.ignoresSafeArea()
          
    }
}
/*struct ListadoUbicacionesView_Previews: PreviewProvider {
 static var previews: some View {
 ListadoUbicacionesView()
 }
 }*/

