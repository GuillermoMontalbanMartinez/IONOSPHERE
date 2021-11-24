//
//  RegistroView.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 24/11/21.
//

import SwiftUI

struct RegistroView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: -140) {
                Image("AppLogo").resizable().frame(width: 200, height: 200, alignment: .center)
                VStack(alignment: .center, spacing:20) {
                    HStack {
                        Text("Nombre      ")
                        TextField("Nombre usuario", text: $username)
                                .padding()
                                .cornerRadius(5.0)
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 2))
                        }.frame(width: 325, height: 70, alignment: .center)
                        
                    HStack {
                        Text("Contraseña")
                        TextField("Contraseña", text: $password)
                            .padding()
                            .cornerRadius(5.0)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 2))
                            .padding(.bottom,20)
                    }.frame(width: 325, height: 70, alignment: .center)
                    
                    HStack {
                        Text("Repetir Contraseña").frame(width: 90, height: 70, alignment: .leading)
                        TextField("Repetir Contraseña", text: $repeatPassword)
                            .padding()
                            .cornerRadius(5.0)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 2))
                            .padding(.bottom,20)
                    }.frame(width: 325, height: 70, alignment: .center)
                        
                    Button( action: {
                        //iniciarSesion(nombre: username, contraseña: password)
                        
                        
                    }, label: {
                        Text("Registrarse")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 13.0/255.0, green: 16.0/255.0, blue: 51.0/255.0))
                            .cornerRadius(13)
                            .shadow(radius: 16)
                            .frame(width: 250, height: 90, alignment: .center)
                    })
                }.frame(width: geometry.size.width/1.1, height: geometry.size.height/2, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(30)
                    .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                    .shadow(radius: 10)
               
                Button(action: {
                    
                }, label : {
                    Text("¿Ya tienes cuenta?")
                    Text("Inicia sesión").underline()
                }).frame(width: 400, height: 200, alignment: .center)
            }
        }
    }
}

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView()
    }
}
