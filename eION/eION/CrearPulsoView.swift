//
//  CrearPulsoView.swift
//  eION
//
//  Created by Jorge Mora Campoy on 26/11/21.
//
import SwiftUI
import AVFoundation

struct CrearPulsoView: View {
    @EnvironmentObject var vm: ViewModel
    var ubicacion :String = "Almería"
    @State var valorPorVoz : String = ""
    @State var valorSlider : Double = 0
    @State var modoGrabacion : Bool = false
    @State var isRecording = false
    @State private var indexClase = 0
    var listaClases: [String] = ["Good", "Bad"]
    @State var claseElegida: Bool = true
    
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Section{
                        VStack{
                            Spacer()
                            Text("Introduzca un valor para A03: \((round(100000 * valorSlider) / 100000))").padding(.top)
                            Slider(value: $valorSlider, in: -1...1).frame(width:300)
                            Spacer()
                            
                            HStack{
                                Text("Introduzca un valor para A27: \(valorPorVoz) ")
                                Spacer()
                                Image(systemName: "mic.fill").resizable().frame(width:25, height: 32).onTapGesture {
                                    modoGrabacion.toggle()
                                }.sheet(isPresented: $modoGrabacion ){
                                    MicrofonoView(valorPorVoz: $valorPorVoz,modoGrabacion: $modoGrabacion)
                                }
                            }.frame(width: 300, alignment: .leading)
                            
                            
                            /*Text("Introduzca un valor para A27: \((round(100000 * valorPorVoz) / 100000))").padding(.top)
                             Slider(value: $valorPorVoz, in: -1...1).frame(width:300)*/
                            
                            //}.frame(width: 300, alignment: .center)
                            
                            HStack {
                                Text("Clase")
                                Picker("Elija su clase", selection: $indexClase) {
                                    ForEach(0 ..< listaClases.count) {
                                        Text (self.listaClases[$0])
                                    }
                                }.pickerStyle(.segmented)
                                    .padding()
                                    .onChange(of: indexClase) { index in
                                        claseElegida = listaClases[index] == "Good" ? true : false
                                    }
                            }
                            
                            VStack{
                                Button(action:{
                                    print("Pulso creado")
                                    let valorSliderRedondeado  = String(String(valorSlider).prefix(7))
                                    let valorPorVozRedondeado  = Double(valorPorVoz) ?? 0
                                    
                                    
                                    valorSlider = Double(valorSliderRedondeado) ?? 0.0
                                    // valorPorVoz = Double(valorPorVozRedondeado)
                                    /* let formater = DateFormatter()
                                     formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                     let fecha = formater.string(from: Date())*/
                                    
                                
                                    vm.addPulso(fechaCreacion: Date(), clase: claseElegida, ubicacion: ubicacion, a27: valorPorVozRedondeado, a03: valorSlider, nombrePulso: "Pulso 1")
                                    print("Pulso creado")
                                    
                                }, label:{
                                    Text("Crear pulso")
                                    
                                }).frame(width: 150, height: 50 ).foregroundColor(.white).background(Color.accentColor).cornerRadius(10).padding()
                                
                            }.frame(width : 265)
                        }.listRowSeparator(.hidden)
                        
                        
                    }.frame(width: 350, height:450 ).background(.white).cornerRadius(30).shadow( radius: 10).onAppear(perform: {
                        UITableView.appearance().backgroundColor = .clear
                        
                    })
                    
                }.navigationTitle(Text("Nuevo pulso"))
            }
        }
    }
    
    
    /*struct CrearPulsoView_Previews: PreviewProvider {
     static var previews: some View {
     CrearPulsoView()
     }
     }*/
    
}


