//
//  EditarPerfilView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 17/12/21.
//

import SwiftUI

struct EditarPerfilView: View {
    @State var nombre = ""
    @State var mostrarImagePicker: Bool = false
    @State var imageGeneral: UIImage = UIImage()
    @EnvironmentObject var vm : ViewModel
    @State var datosActualizados = 0
    
    var body: some View {
        ZStack {
            
            BackgroundView(height: 40)//.padding(.top, -200)
            
            RoundedRectangle(cornerRadius: 40).background(.thinMaterial)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).blur(radius: 100)
            
            if ( vm.loading ) {
                ProgressView().foregroundColor(.black)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack {
                        EditarPerfilFormulario(nombre: $nombre, mostrarImagePicker: $mostrarImagePicker, imageGeneral: $imageGeneral, datosActualizados: $datosActualizados)
                            .environmentObject(vm)
                        PulsosGuardados().environmentObject(vm)
                        PulsosCreados().environmentObject(vm)
                        
                    }.frame(maxWidth: .infinity).padding(.top, 150).padding(.bottom, 50)
                }
                
            }
        }.ignoresSafeArea()
        
        
    }
}

struct PulsosCreados: View {
    @EnvironmentObject var vm : ViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tus pulsos creados").font(.custom("Poppins-Regular", size: 26)).foregroundColor(.black).fontWeight(.bold)
            if let pulsos = vm.usuarioLogeado?.pulsoRelation?.allObjects as? [Pulso] {
                if pulsos.count != 0 {
                    ForEach(pulsos) { pulso in
                        PulsoInfo(pulso: pulso).listRowInsets(EdgeInsets()).padding().listRowSeparator(.hidden).environmentObject(vm)
                    }
                } else {
                    Text("No has creado pulsos todavía").font(.custom("Poppins-Regular", size: 18)).foregroundColor(.red).fontWeight(.bold)
                }
            }
        }.padding()
    }
}

struct PulsosGuardados: View {
    @EnvironmentObject var vm : ViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Tus pulsos guardados").font(.custom("Poppins-Regular", size: 26)).foregroundColor(.black).fontWeight(.bold)
            if let pulsos = vm.usuarioLogeado?.guardaPulsoRelation?.allObjects as? [Pulso] {
                if pulsos.count != 0 {
                    ForEach(pulsos) { pulso in
                        PulsoInfo(pulso: pulso).listRowInsets(EdgeInsets()).padding().listRowSeparator(.hidden).environmentObject(vm)
                    }
                } else {
                    Text("No tiene pulsos guardados todavía").font(.custom("Poppins-Regular", size: 18)).foregroundColor(.red).fontWeight(.bold)
                }
            }
        }.padding()
    }
}

struct PulsoInfo : View {
    var pulso: Pulso
    @State var mostrarPulso = false
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        
        HStack {
            Text(pulso.nombrePulso ?? "" ).font(.custom("Poppins-Regular", size: 18)).fontWeight(.bold).foregroundColor(.accentColor)
            
            Spacer()
            
            Text("0").font(.custom("Poppins-Regular", size: 14)).fontWeight(.bold).foregroundColor(.black.opacity(0.7))
            
        }.sheet(isPresented: $mostrarPulso) {
            PulsoView(pulso: pulso).environmentObject(vm)
        }.padding().background(.ultraThinMaterial).cornerRadius(10)
            .onTapGesture {
                mostrarPulso = true
            }
    }
}

struct EditarPerfilFormulario : View {
    
    @Binding var nombre: String
    @Binding var mostrarImagePicker: Bool
    @Binding var imageGeneral: UIImage
    @Binding var datosActualizados: Int
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        
        VStack {
            Text("Edita tu perfil").font(.custom("Poppins-Regular", size: 28)).foregroundColor(.black)
            Button {
                mostrarImagePicker.toggle() }label:{
                    if vm.usuarioLogeado?.foto != nil {
                        Image(uiImage: UIImage(data: vm.usuarioLogeado?.foto ?? Data()) ?? UIImage())
                            .resizable()
                            .frame(width: 200, height:200)
                            .cornerRadius(100)
                            .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.white, lineWidth: 5))
                            .padding(.vertical)
                    } else {
                        Image("unknown") .resizable()
                            .frame(width: 200, height:200)
                            .cornerRadius(100)
                            .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.white, lineWidth: 5))
                            .padding(.vertical)
                    }
                    
                    
                }
                .sheet(isPresented: $mostrarImagePicker){
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $imageGeneral )
                }
            
            if ( datosActualizados == 1 ) {
                Text("Datos actualizados correctamente").font(.custom("Poppins-Regular", size: 18)).foregroundColor(.green)
            } else if (datosActualizados == 2) {
                Text("Ha ocurrido un error actualizando sus datos").font(.custom("Poppins-Regular", size: 18))
            }
            
            Button {
                if vm.updateUserData(nombre: vm.usuarioLogeado?.nombre ?? "" , imagen: imageGeneral) {
                    datosActualizados = 1
                } else {
                    datosActualizados = 2
                }
            } label: {
                Text("Guardar")
                    .font(.custom("Poppins-Regular", size: 18))
                    .foregroundColor(.accentColor)
                    .padding([.top, .bottom], 15)
                    .padding([.leading, .trailing], 25)
                    .cornerRadius(8)
            }.buttonStyle(CustomButton())
            
        }.padding()
        
    }
}

/*struct EditarPerfilView_Previews: PreviewProvider {
 static var previews: some View {
 EditarPerfilView()
 }
 }*/
