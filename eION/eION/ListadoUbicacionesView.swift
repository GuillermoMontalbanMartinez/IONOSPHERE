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
    var usuario: String = ""
    @EnvironmentObject var vm : ViewModel
    var columns: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                //BackgroundView(height: 50)
                ScrollView {
                    VStack{
                        CustomNavigationView(title:"Ubicación", botones: false, destino: destino, anadir: .constant(false))
                        
                        VStack(alignment: .center, spacing:0) {
                            BusquedaView(text: $text).frame(width: 350, height: 100, alignment: .center)
                            LazyVGrid(columns: columns, spacing: 5) {
                                ForEach(0..<vm.provincias.count ) { index in
                                    if(text.isEmpty || vm.provincias[index].nombre.hasPrefix(text)){
                                        NavigationLink(destination: ListadoPulsosView(provincia: vm.provincias[index], usuario: usuario )){
                                            VStack(alignment: .center, spacing: 0) {
                                                Spacer()
                                                Text(vm.provincias[index].nombre).font(.custom("Poppins-Regular", size: 14)).fontWeight(.bold).offset(y:50)
                                                Image("\(vm.provincias[index].imagen)").resizable().frame(width: 200, height: 200)
                                                Spacer()
                                            }.padding().frame(width: 170, height: 170).background(Color("Secondary")).cornerRadius(30)
                                        }
                                    }
                                }
                            }.padding().frame(width: 400).background(Color("Background")).cornerRadius(20).foregroundColor(Color("Color"))
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
        }.ignoresSafeArea().background(Color("Background"))
        
    }
}
/*struct ListadoUbicacionesView_Previews: PreviewProvider {
 static var previews: some View {
 ListadoUbicacionesView()
 }
 }*/

