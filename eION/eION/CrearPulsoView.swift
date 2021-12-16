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
    @State var nombrePulso : String = ""
    @State var emptyPulso : Bool = false
    @State var emptyA27 : Bool = false
    @State var modoGrabacion : Bool = false
    @State var isRecording = false
    @State private var indexClase = 0
    var listaClases: [String] = ["Good", "Bad"]
    @State var claseElegida: Bool = true
    
    var body: some View {
        GeometryReader {geometry in
            VStack(alignment: .leading){
                
                if emptyPulso {
                    Label("Introduzca nombre del pulso", systemImage: "xmark.octagon")
                        .foregroundColor(.red)
                        .offset(x:10, y: 50)
                }
                if emptyA27 {
                    Label("Introduzca valor A27", systemImage: "xmark.octagon")
                        .foregroundColor(.red)
                        .offset(x:10, y: 50)
                }

                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text("Nombre del pulso: ").frame(width: 150, alignment: .leading)
                        
                        TextField("", text: $nombrePulso).frame(alignment: .leading)
                        Spacer()
                    }.padding(.leading).padding(.top)
                    
                    Text( "Valor para A03: \((round(100000 * valorSlider) / 100000))").padding(.top)
                    Slider(value: $valorSlider, in: -1...1).frame(width:300)
                    
                    HStack{
                        Text("Valor para A27: \(valorPorVoz) ")
                        Spacer()
                        Image(systemName: "mic.fill").resizable().frame(width:25, height: 32).onTapGesture {
                            modoGrabacion.toggle()
                        }.sheet(isPresented: $modoGrabacion ){
                            MicrofonoView(valorPorVoz: $valorPorVoz,modoGrabacion: $modoGrabacion)
                        }
                    }
                    
                    #if eIONB
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
                    #endif
                    
                    VStack{
                        Button {
                            emptyPulso = false
                            emptyA27 = false
                            if nombrePulso.isEmpty {
                                emptyPulso = true
                            }else if(valorPorVoz.isEmpty){
                                emptyA27 = true
                            }else{
                                print("Pulso creado")
                                let valorSliderRedondeado  = String(String(valorSlider).prefix(7))
                                let valorPorVozRedondeado  = Double(valorPorVoz) ?? 0
                                
                                valorSlider = Double(valorSliderRedondeado) ?? 0.0
                                // valorPorVoz = Double(valorPorVozRedondeado)
                                
#if eIONML
                                claseElegida = vm.calcularClase(a05: valorSlider, a27: valorPorVozRedondeado )
#endif
                                
                                vm.addPulso(fechaCreacion: Date(), clase: claseElegida, ubicacion: ubicacion, a27: valorPorVozRedondeado, a03: valorSlider, nombrePulso: nombrePulso)
                                print("Pulso creado")
                            }
                            
                            
                        } label: {
                            Text("Crear pulso")
                                .foregroundColor(.white)
                                .padding([.top, .bottom], 15)
                                .padding([.leading, .trailing], 25)
                        }.buttonStyle(CustomButton())
                        
                        
                    }
                }
                
            }.frame(width: geometry.size.width/1.5, height: geometry.size.height/2, alignment: .center)
                .padding(.init(top: 40, leading:  30, bottom: 40, trailing: 30))
                .background(Color.white)
                .cornerRadius(30)
                .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                .shadow(radius: 10).onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
        }
    }
    
}


/*struct CrearPulsoView_Previews: PreviewProvider {
 static var previews: some View {
 CrearPulsoView()
 }
 }*/
