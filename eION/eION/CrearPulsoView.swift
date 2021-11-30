//
//  CrearPulsoView.swift
//  eION
//
//  Created by Jorge Mora Campoy on 26/11/21.
//
import SwiftUI
import AVFoundation

struct CrearPulsoView: View {
    var clases = ["a03","a27"]
    @State var valorPorVoz : String = ""
    @State var claseSeleccionada = ""
    @State var valorSlider : Double = 0
    @State var modoGrabacion : Bool = false
    @State var isRecording = false
    
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
                            
                            HStack{
                                NavigationView {
                                    Form {
                                        Section {
                                            Picker("Seleccionar clase", selection: $claseSeleccionada) {
                                                ForEach(clases, id: \.self) {
                                                    Text($0)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                            VStack{
                                Button(action:{
                                    print("Pulso creado")
                                    let valorSliderRedondeado  = String(String(valorSlider).prefix(7))
                                    
                                    valorSlider = Double(valorSliderRedondeado) ?? 0.0
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
    
    struct CrearPulsoView_Previews: PreviewProvider {
        static var previews: some View {
            CrearPulsoView()
.previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}

