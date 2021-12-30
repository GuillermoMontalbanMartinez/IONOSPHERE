//
//  RegistroView.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 24/11/21.
//

import SwiftUI

struct RegistroView: View {
    @State var showView: Bool = false
    @EnvironmentObject var model: ViewModel
    var body: some View {
        VStack() {
            VStack {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .clipShape(Circle())
                    .frame( alignment: .top)
            }.padding(40)
            

            GeometryReader { geo in
                VStack(spacing: 0) {
                    Spacer()

                    Text("Regístrate").font(.custom("Poppins-Regular", size: 28)).fontWeight(.bold).foregroundColor(.white)
                    
                    RegistroForm().environmentObject(model)
                }.offset(y:-50).background(wave(waveHeight: 30, phase: Angle(degrees: (Double(geo.frame(in: .global).minY) + 45) * -1 * 0.7))
                 .foregroundColor(.accentColor).opacity(1))
            }

        }.ignoresSafeArea()
    }
}

private struct RegistroForm: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    @State var registeredUser: Bool = false
    @State var differentPassword: Bool = false
    @State var emptyUsername: Bool = false
    @State var emptyPassword: Bool = false
    @State var emptyRepeatPassword: Bool = false
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                HStack(alignment: .bottom) {
                    CustomTextFieldView(text: $username, name: "Nombre de usuario")
                }
                            
                HStack(alignment: .bottom) {
                    CustomSecureFieldView(text: $password, name: "Contraseña")
                }
                            
                 HStack(alignment: .bottom) {
                     CustomSecureFieldView(text: $repeatPassword, name: "Repetir contraseña")
                }
                
                Button {
                    emptyUsername = false
                    emptyPassword = false
                    emptyRepeatPassword = false
                    registeredUser = false
                    differentPassword = false
                    
                    if username.isEmpty && password.isEmpty && repeatPassword.isEmpty {
                        emptyUsername = true
                        emptyPassword = true
                        emptyRepeatPassword = true
                    } else if username.isEmpty && password.isEmpty {
                        emptyUsername = true
                        emptyPassword = true
                    } else if username.isEmpty && repeatPassword.isEmpty{
                        emptyUsername = true
                        emptyRepeatPassword = true
                    } else if password.isEmpty && repeatPassword.isEmpty {
                        emptyPassword = true
                        emptyRepeatPassword = true
                    } else if username.isEmpty {
                        emptyUsername = true
                    } else if password.isEmpty {
                        emptyPassword = true
                    } else if repeatPassword.isEmpty {
                        emptyRepeatPassword = true
                    } else if password != repeatPassword {
                        differentPassword = true
                    } else {
                        #if eIONB
                        do {
                            try model.addUsuario(nombre: username, password: password)
                        } catch eION.ViewModel.error.datoRepetido {
                            print("Usuario existente en la base de datos")
                            registeredUser = true
                            
                        } catch {
                            print("Error desconocido")
                        }
                        #endif
                        
                        
                        #if eIONML
                        do {
                            try model.addUsuario(nombre: username, password: password)
                        } catch eION_copy.ViewModel.error.datoRepetido {
                            print("Usuario existente en la base de datos")
                            registeredUser = true
                        } catch {
                            print("Error desconocido")
                        }
                        
                        #endif
   
                    }

                } label: {
                    Text("Registrarse", tableName: "Login")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.accentColor)
                        .padding([.top, .bottom], 15)
                        .padding([.leading, .trailing], 25)
                        .cornerRadius(8)
                        //.shadow(color: Color(red: 13.0/255.0, green: 16.0/255.0, blue: 51.0/255.0).opacity(0.4), radius: 1, y: 4)
                }.buttonStyle(CustomButton())
                
                if emptyUsername && emptyPassword && emptyRepeatPassword {
                    Label("Introduzca los datos", systemImage: "xmark.octagon").font(.custom("Poppins-Regular", size: 18))

                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                } else if emptyUsername && emptyPassword {
                    Label("Introduzca el usuario y la contraseña", systemImage: "xmark.octagon")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                } else if emptyUsername && emptyRepeatPassword {
                    Label("Introducir el usuario y la repetición", systemImage: "xmark.octagon")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                } else if emptyPassword && emptyRepeatPassword {
                    Label("Introduzca la contraseña y la repetición", systemImage: "xmark.octagon")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                } else if emptyUsername {
                    Label("Introduzca el nombre de usuario", systemImage: "xmark.octagon")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                } else if emptyPassword{
                    Label("Introduzca la contraseña", systemImage: "xmark.octagon")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                } else if emptyRepeatPassword {
                    Label("Repita la contraseña", systemImage: "xmark.octagon")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                } else if registeredUser {
                    Label("El usuario ya existe", systemImage: "xmark.octagon")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                } else if differentPassword {
                    Label("Las contraseñas deben ser iguales", systemImage: "xmark.octagon")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                }
            }.padding([.leading, .trailing], 20)
             .padding([.top, .bottom], 30)
        }//.background()
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.4), radius: 4)
            .padding([.leading, .trailing])
    }
}

/*struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView().environmentObject(ViewModel())
    }
}*/
