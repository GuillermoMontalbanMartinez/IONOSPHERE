//
//  LoginView.swift.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 24/11/21.
//

import SwiftUI

struct LoginView: View {
    @State var showView: Bool = false
    @Binding var logeado: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack {
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .clipShape(Circle())
                        .frame( alignment: .top)
                }.offset(y: 0)
                
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        Spacer()
                        Text("Inicia sesión").font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                        LoginForm(logeado: $logeado)
                        HStack() {
                            Text("¿No tienes cuenta?", tableName: "Login").foregroundColor(.white)
                             Button {
                                 showView = true
                             } label: {
                                 Text("Registrate", tableName: "Login")
                                     .foregroundColor(.white)
                                    .underline()
                                    .bold()
                            }
                            NavigationLink(destination: RegistroView(), isActive: $showView) {
                                    EmptyView()
                            }
                        }
                    }.offset(y:-100).background(wave(waveHeight: 30, phase: Angle(degrees: (Double(geo.frame(in: .global).minY) + 45) * -1 * 0.7))
                                                    .foregroundColor(.accentColor).opacity(1))
                }
            }.ignoresSafeArea()
        }
    }
}

private struct LoginForm: View {
    @State var username:String = ""
    @State var password:String = ""
    @State var emptyUsername: Bool = false
    @State var emptyPassword: Bool = false
    @State var failLogin: Bool = false
    @EnvironmentObject var vm : ViewModel
    @Binding var logeado: Bool
    
    
    @State var isTapped = false
    
    var body: some View {
        
        VStack {
            VStack(spacing: 30) {
                HStack(alignment: .bottom) {
                    CustomTextFieldView(text: $username, name: "Nombre")
                }
            
                HStack(alignment: .bottom) {
                    CustomSecureFieldView(text: $password, name: "Contraseña")
                }
            }.padding([.leading, .trailing], 20)
             .padding([.top, .bottom], 30)
            
            Button {
                emptyUsername = false
                emptyPassword = false
                
                if username.isEmpty && password.isEmpty {
                    emptyUsername = true
                    emptyPassword = true
                } else if username.isEmpty {
                    emptyUsername = true
                } else if password.isEmpty {
                    emptyPassword = true
                } else {
                    if vm.iniciarSesion(nombre: username, contraseña: password) {
                        logeado.toggle()
                        print(logeado)
                    } else {
                        failLogin = true
                        print("Error")
                    }
                }
 
            } label: {
                Text("Iniciar sesión", tableName: "Login")
                    .foregroundColor(.accentColor)
                    .padding([.top, .bottom], 15)
                    .padding([.leading, .trailing], 25)
                    .cornerRadius(8)
                   /* .shadow(color: Color(red: 13.0/255.0, green: 16.0/255.0, blue: 51.0/255.0).opacity(0.4), radius: 1, y: 4)*/
            }.buttonStyle(CustomButton())
        }//.background()
         .cornerRadius(20)
         .shadow(color: .gray.opacity(0.4), radius: 4)
         .padding([.leading, .trailing])
        
        if emptyUsername && emptyPassword {
            Label("Introduzca el usuario y la contraseña", systemImage: "xmark.octagon")
                .foregroundColor(.red)
                .offset(x: 10, y:-40)
        } else if emptyUsername {
            Label("Introduzca el nombre del usuario", systemImage: "xmark.octagon")
                .foregroundColor(.red)
                .offset(x: 10, y:-180)
        } else if emptyPassword {
            Label("Introduzca la contraseña", systemImage: "xmark.octagon")
                .foregroundColor(.red)
                .offset(x: 10, y:-130)
        }

        if failLogin {
            Label("Datos incorrectos", systemImage: "xmark.octagon")
                .foregroundColor(.red)
                .offset(x: 10, y:-40)
        }
    }
}

struct LoginView_swift_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(logeado: .constant(false))
.previewInterfaceOrientation(.portrait)
    }
}
