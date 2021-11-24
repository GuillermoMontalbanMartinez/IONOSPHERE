//
//  LoginView.swift.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 24/11/21.
//

import SwiftUI

struct LoginView_swift: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                Image("AppLogo").resizable().frame(width: 200, height: 200, alignment: .center)
                VStack {
                    HStack {
                        Text("Nombre      ")
                        TextField("Nombre usuario", text: $username)
                            .padding()
                            .cornerRadius(5.0)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 2))
                    }
                    
                    HStack {
                        Text("Contraseña")
                        TextField("Contraseña", text: $password)
                            .padding()
                            .cornerRadius(5.0)
                            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 2))
                            .padding(.bottom,20)
                    }
                    
                    Button( action: {
                        //iniciarSesion(nombre: username, contraseña: password)
                        print("Hello world \(username)")
                        
                    }, label: {
                        Text("Iniciar sesión")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color(red: 13.0/255.0, green: 16.0/255.0, blue: 51.0/255.0))
                            .cornerRadius(13)
                            .shadow(radius: 16)
                            .frame(width: 250, height: 90, alignment: .center)
                    })
                    
                }.shadow(color: Color.gray, radius: 16, x: 5, y: 5).background(Color.white)
                    //.overlay(
                          //  RoundedRectangle(cornerRadius: 16)
                             //   .stroke(Color.gray, lineWidth: 3))
                    .frame(width: 350, height: 325)
                    
                Button(action: {
                    
                }, label : {
                    Text("¿No tienes cuenta?")
                    Text("Registrate").underline()
                })
                    
                    
            }
            
        }
        
    }
}

struct LoginView_swift_Previews: PreviewProvider {
    static var previews: some View {
        LoginView_swift()
    }
}
