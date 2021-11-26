//
//  CrearPulsoView.swift
//  eION
//
//  Created by Jorge Mora Campoy on 26/11/21.
//
import SwiftUI

struct CrearPulsoView: View {
    var clases = ["a03","a27"]
    @State var claseSeleccionada = ""
    @State var valorSliderRedondeado : String = ""
    @State var valorSlider : Double = 0
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
                                    
                                }
                            Spacer()
                                HStack{
                                    NavigationView {
                                               Form {
                                                   Section {
                                                       Picker("Seleccionar clase", selection: $claseSeleccionada) {
                                                           ForEach(clases, id: \.self) {
                                                               Text($0)
                                                    }
                                                }
                                            }.padding()
                                        }
                                }
                        }
                            
                        VStack{
                        Button(action:{
                            print("Pulso creado")
                            valorSliderRedondeado  = String(String(valorSlider).prefix(7))
                            
                            valorSlider = Double(valorSliderRedondeado) ?? 0.0
                        }, label:{
                            Text("Crear pulso")
                            
                        }).frame(width: 150, height: 50 ).foregroundColor(.white).background(Color.accentColor).cornerRadius(10).padding()
                       
                        }.frame(width : 265)
                  }.listRowSeparator(.hidden)
              
                
            }.frame(width: 350, height:400 ).background(.white).cornerRadius(30).shadow( radius: 10).onAppear(perform: {
                UITableView.appearance().backgroundColor = .clear
            })
           
        }.navigationTitle(Text("Nuevo pulso").font(.largeTitle).foregroundColor(Color.accentColor))
        }
    }
}

struct CrearPulsoView_Previews: PreviewProvider {
    static var previews: some View {
        CrearPulsoView()
        }
    }
}

