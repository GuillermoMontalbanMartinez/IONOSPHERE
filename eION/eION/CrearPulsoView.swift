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
        ZStack {
            GeometryReader {geo in
                
                BackgroundView(height: 40).padding(.top, -300)
                
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("Crear un pulso").font(.custom("Poppins-Regular", size: 28)).fontWeight(.bold).foregroundColor(.black)

                    if emptyPulso {
                        Label("Introduzca nombre del pulso", systemImage: "xmark.octagon")
                            .font(.custom("Poppins-Regular", size: 18))
                            .foregroundColor(.red)
                            .offset(x:10, y: 50)
                    }
                    if emptyA27 {
                        Label("Introduzca valor A27", systemImage: "xmark.octagon")
                            .font(.custom("Poppins-Regular", size: 18))
                            .foregroundColor(.red)
                            .offset(x:10, y: 50)
                    }
                    
                    VStack {
                        CustomTextFieldView(text: $nombrePulso, name: "Nombre del pulso").foregroundColor(.black)
                        
                        Text( "Valor para A03: \((round(100000 * valorSlider) / 100000))")
                            .font(.custom("Poppins-Regular", size: 18)).padding(.top)
                        Slider(value: $valorSlider, in: -1...1).frame(width:300).accentColor(.accentColor)
                        
                        HStack{
                            Text("Valor para A27: \(valorPorVoz) ").font(.custom("Poppins-Regular", size: 18))
                            Spacer()
                            Image(systemName: "mic.fill").resizable().frame(width:25, height: 32).onTapGesture {
                                modoGrabacion.toggle()
                            }.sheet(isPresented: $modoGrabacion ){
                                MicrofonoView(valorPorVoz: $valorPorVoz,modoGrabacion: $modoGrabacion)
                            }
                        }
                    }
                    
#if eIONB
                    HStack {
                        Text("Clase").font(.custom("Poppins-Regular", size: 18))
                        Picker("Elija su clase", selection: $indexClase) {
                            ForEach(0 ..< listaClases.count) {
                                Text (self.listaClases[$0]).font(.custom("Poppins-Regular", size: 18))
                            }
                        }.pickerStyle(.segmented)
                            .padding()
                            .onChange(of: indexClase) { index in
                                claseElegida = listaClases[index] == "Good" ? true : false
                            }
                    }
#endif
                    
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
                            
                            print("Vamos a crear el pulso")
                            
                            vm.addPulso(fechaCreacion: Date(), clase: claseElegida, ubicacion: ubicacion, a27: valorPorVozRedondeado, a03: valorSlider, nombrePulso: nombrePulso, nombreUsuario: vm.usuarioLogeado?.nombre ?? "")
                            
                            print("Pulso creado")
                        }
                        
                        
                    } label: {
                        Text("Crear pulso")
                            .font(.custom("Poppins-Regular", size: 18))
                            .foregroundColor(.accentColor)
                            .padding([.top, .bottom], 15)
                            .padding([.leading, .trailing], 25)
                    }.buttonStyle(CustomButton())
                    
                } .padding(.init(top: 40, leading:  30, bottom: 40, trailing: 30))
                    
                
                //.background(Color.white)
                //.cornerRadius(30)
                .foregroundColor(.black)
                
                //.position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                //shadow(radius: 10)

                
            }//.frame(width: geo.size.width/1.4, height: geo.size.height/2, alignment: .center)
        }
    }
}


/*struct CrearPulsoView_Previews: PreviewProvider {
 static var previews: some View {
 CrearPulsoView()
 }
 }*/
