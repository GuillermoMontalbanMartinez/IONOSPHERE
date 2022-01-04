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
    var ubicacion :String
    @State var valorPorVoz : String = "0.0"
    @State var valorPorVozRedondeado : Double = 0
    @State var valorSlider : Double = 0
    @State var comprobacion : Bool = false
    @State var nombrePulso : String = ""
    @State var emptyPulso : Bool = false
    @State var emptyA27 : Bool = false
    @State var modoGrabacion : Bool = false
    @State var isRecording = false
    @State private var indexClase = 0
    var listaClases: [String] = ["Good", "Bad"]
    @State var claseElegida: Bool = true
    @State var pulsoCreado : Bool = false
    
    var body: some View {
        ZStack {
            Color("Background")
            GeometryReader {geo in
                    
                VStack(alignment: .center) {
                    Spacer()
                    Text(NSLocalizedString("form-title-principal-crearpulso-key", comment: "")).font(.custom("Poppins-Regular", size: 28)).fontWeight(.bold)

                    if emptyPulso {
                        Label("Introduzca nombre del pulso", systemImage: "xmark.octagon")
                            .font(.custom("Poppins-Regular", size: 18))
                            .foregroundColor(.red)
                          
                    }
                    if emptyA27 {
                        Label("Introduzca valor A27", systemImage: "xmark.octagon")
                            .font(.custom("Poppins-Regular", size: 18))
                            .foregroundColor(.red)
                           
                    }
                    
                    if comprobacion {
                        Label("A27 tiene que ser un valor numérico valor entre -1 y 1", systemImage: "xmark.octagon")
                            .font(.custom("Poppins-Regular", size: 18))
                            .foregroundColor(.red)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        CustomTextFieldView(text: $nombrePulso, name: NSLocalizedString("form-name-login-key", comment: ""))
                        
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(NSLocalizedString("form-a05-text-key", comment: "\((round(100000 * valorSlider) / 100000))")).font(.custom("Poppins-Regular", size: 18)).padding(.top)
                                Text("\((round(100000 * valorSlider) / 100000))")
                                    .font(.custom("Poppins-Regular", size: 18)).padding(.top)
                            }
                            
                            Slider(value: $valorSlider, in: -1...1).frame(width:350).accentColor(.accentColor)
                            
                        }

                        HStack{
                            HStack {
                                Text(NSLocalizedString("form-a27-text-key", comment: "")).font(.custom("Poppins-Regular", size: 18))
                                Text("\(valorPorVoz.removeWhitespace()) ").font(.custom("Poppins-Regular", size: 18))
                            }
                            //Text("form-a27-text-key \(valorPorVoz.removeWhitespace()) ").font(.custom("Poppins-Regular", size: 18))
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
                        Text(NSLocalizedString("form-class-key", comment: "")).font(.custom("Poppins-Regular", size: 18))
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
                        comprobacion = false
                        
                        if nombrePulso.isEmpty {
                            emptyPulso = true
                        } else if(valorPorVoz.isEmpty){
                            emptyA27 = true
 
                        } else{
                            let valorSliderRedondeado  = String(String(valorSlider).prefix(7))
                            valorSlider = Double(valorSliderRedondeado) ?? 0.0
                            
                            valorPorVoz = valorPorVoz.removeWhitespace()
                            valorPorVoz = String(valorPorVoz.prefix(8))
                            
                            let numericSet : [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                            let filteredCharacters = valorPorVoz.filter {
                              return numericSet.contains($0)
                            }
                            
                            let filteredString = String(filteredCharacters)
                            
                            if(filteredString == ""){
                                comprobacion = true
                            }else{
                                valorPorVozRedondeado = Double(valorPorVoz)!
                            }
                            
                            if (valorPorVozRedondeado > 1 || valorPorVozRedondeado < -1){
                               comprobacion = true
                            }
                           
                            
#if eIONML
                            claseElegida = vm.calcularClase(a05: valorSlider, a27: valorPorVozRedondeado)
#endif
                            
                            if(comprobacion == false){
                            vm.addPulso(fechaCreacion: Date(), clase: claseElegida, ubicacion: ubicacion, a27: valorPorVozRedondeado, a03: valorSlider, nombrePulso: nombrePulso, nombreUsuario: vm.usuarioLogeado?.nombre ?? "")
                            
                            pulsoCreado.toggle()
                            nombrePulso = ""
                            valorSlider = 0
                            valorPorVoz = ""
                            }
                            
                        }
                        
                        
                    } label: {
                        Text(NSLocalizedString("form-title-crearpulso-key", comment: ""))
                            .font(.custom("Poppins-Regular", size: 18))
                            .padding([.top, .bottom], 15)
                            .padding([.leading, .trailing], 25)
                    }.buttonStyle(CustomButton())
                    
                    if pulsoCreado{
                      
                        Text("Pulso creado")
                            .font(.custom("Poppins-Regular", size: 18))
                            .foregroundColor(Color("GoodClass"))
                            .offset(y: -50)
                        
                        
                    }
                } .padding(.init(top: 40, leading:  30, bottom: 40, trailing: 30)).onDisappear(){
                    pulsoCreado = false
              
                }
                
            }
            
        }.background(Color("Background"))
        
    }
}

extension String {
 
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return String(self.replace(string: ",", replacement: ".").prefix(9))
    }
  }


/*struct CrearPulsoView_Previews: PreviewProvider {
 static var previews: some View {
 CrearPulsoView()
 }
 }*/
