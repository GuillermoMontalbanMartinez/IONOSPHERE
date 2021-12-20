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
    var provincias: [String] = ["Almería", "Ávila", "Barcelona", "Zaragoza"]
    
    var columns: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                GeometryReader { geometry in
                    BackgroundView(height: 50)
                    ScrollView {
                        VStack{
                            CustomNavigationView(title:"Ubicación", botones: false, destino: destino, anadir: .constant(false))
                            VStack(alignment: .center, spacing:20) {
                                BusquedaView(text: $text)
                                Spacer()
                                
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(0..<provincias.count ) { index in
                                        if(text.isEmpty || provincias[index].hasPrefix(text)){
                                            NavigationLink(destination: ListadoPulsosView(provincia: provincias[index])){
                                                //FilaTablaview(tituloIzq: provincia, tipoUsuario: true)
                                                VStack(alignment: .leading) {
                                                    Text(provincias[index]).font(.headline).foregroundColor(.black).fontWeight(.bold)
                                                    Image("barcelona").resizable().frame(width: 100, height: 100)
                                                }.padding().frame(width: 150, height: 150).background(.white).cornerRadius(30)
                                            }
                                            
                                            
                                        }
                                    }
                                }.frame(width: 300)
                                
                                
                                    .scaledToFit()
                                    .onAppear(){
                                        UITableView.appearance().backgroundColor = .clear
                                        UITableViewCell.appearance().backgroundColor = .blue
                                    }
                                
                            }
                            .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height*0.70, alignment: .center)
                            //.background(Color.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .cornerRadius(30)
                            //.shadow(radius: 10)
                            
                        }.navigationBarHidden(true).frame(height: geometry.size.height)
                    }
                    
                }
            }
            
            
        }
        //.navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

/*struct ListadoUbicacionesView_Previews: PreviewProvider {
 static var previews: some View {
 ListadoUbicacionesView()
 }
 }*/

