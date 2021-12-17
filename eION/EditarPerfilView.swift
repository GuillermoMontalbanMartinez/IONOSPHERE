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
            
            BackgroundView(height: 40).padding(.top, -200)
            
            
            VStack {
                
                Button {
                mostrarImagePicker.toggle() }label:{
                    Image(uiImage: imageGeneral) .resizable()
                        .frame(width: 200, height:200)
                        .cornerRadius(100)
                        .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.white, lineWidth: 5))
                        .padding(.vertical)
                    
                }
                .sheet(isPresented: $mostrarImagePicker){
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $imageGeneral )
                }
                
                if ( datosActualizados == 1 ) {
                    Text("Datos actualizados correctamente").font(.headline).foregroundColor(.green)
                } else if (datosActualizados == 2) {
                    Text("Ha ocurrido un error actualizando sus datos").font(.headline).foregroundColor(.red)
                }

                Button {
                    if vm.updateUserData(nombre: vm.usuarioLogeado?.nombre ?? "" , imagen: imageGeneral) {
                        datosActualizados = 1
                    } else {
                        datosActualizados = 2
                    }
                } label: {
                    Text("Guardar")
                        .foregroundColor(.accentColor)
                        .padding([.top, .bottom], 15)
                        .padding([.leading, .trailing], 25)
                        .cornerRadius(8)
                }.buttonStyle(CustomButton())
            }.padding()
            

        }.ignoresSafeArea()
        
        
    }
}

struct EditarPerfilView_Previews: PreviewProvider {
    static var previews: some View {
        EditarPerfilView()
    }
}
