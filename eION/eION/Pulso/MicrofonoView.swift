//
//  MicrofonoView.swift
//  eION
//
//  Created by Jorge Mora Campoy on 26/11/21.
//

import SwiftUI


struct MicrofonoView: View {
    @State var speechRecognizer = SpeechRecognizer()
    @Binding var valorPorVoz :String
    @State var isRecording : Bool = false
    @Binding var modoGrabacion: Bool

    var body: some View {
        ZStack{
            Color("Background")
            VStack {
                Spacer()
                if(!isRecording){
                    VStack{
                        Image(systemName: "mic.circle").resizable().frame(width: 150, height: 150, alignment: .center).foregroundColor(Color.accentColor).onTapGesture {
                            isRecording.toggle()
                            speechRecognizer.record(to: $valorPorVoz)
                        }
                        Text(NSLocalizedString("form-pulsa-grabar-key", comment: "")).padding().font(.custom("Poppins-Regular", size: 14))
                        
                        Button() {
                            modoGrabacion.toggle()
                        } label: {
                            Text(NSLocalizedString("form-cancelar-microno-key", comment: ""))
                                .font(.custom("Poppins-Regular", size: 14))
                        }.padding().background(Color.red).foregroundColor(.white).clipShape(Capsule())
                    }
                } else{
                    VStack{
                        Image(systemName: "waveform.and.mic").resizable().frame(width: 150, height: 150, alignment: .center).foregroundColor(Color.accentColor)
                        if(valorPorVoz.count == 0){
                            Text(NSLocalizedString("form-hable-para-key", comment:"")).padding()
                                .font(.custom("Poppins-Regular", size: 14))
                        }else{
                            HStack {
                                Text(NSLocalizedString("form-valor-a27-microfono-key", comment: ""))
                                Text("\(valorPorVoz.removeWhitespace())")
                            }.padding().font(.custom("Poppins-Regular", size: 14))
                        }
                        
                        Button(){
                            isRecording.toggle()
                            speechRecognizer.stopRecording()
                        } label : {
                            Text(NSLocalizedString("form-hecho-microfono-key", comment: ""))
                                .font(.custom("Poppins-Regular", size: 14))
                        }.padding().background(Color.green).foregroundColor(.white).clipShape(Capsule())
                    }.onAppear{
                        
                    }
                }
                            
                Spacer()
            }
        }

    }
}

/*struct MicrofonoView_Previews: PreviewProvider {
    static var previews: some View {
        MicrofonoView(valorPorVoz: .constant(""),modoGrabacion: .constant(true))
    }
}*/

