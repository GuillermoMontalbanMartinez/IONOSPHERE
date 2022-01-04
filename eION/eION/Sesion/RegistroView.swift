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
        GeometryReader { geo in
            VStack() {
                VStack {
                    wave(waveHeight: 30, phase: Angle(degrees: (Double(geo.frame(in: .global).minY) + 45) * -1 * 0.7)).fill(Color.accentColor)
                        .rotationEffect(Angle(degrees:180))
                        .frame(height: 200)
                    
                }.ignoresSafeArea().frame(width: 400, height: 250)
                    .background(
                        wave(waveHeight: 30, phase: Angle(degrees: (Double(geo.frame(in: .global).minY) + 45) * -1 * 0.7)).fill(Color("Secondary"))
                            .rotationEffect(Angle(degrees:180))
                            .frame(height: 250)
                        )
                
                Spacer()
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        Spacer()

                        Text("form-title-signup-key").font(.custom("Poppins-Regular", size: 38)).fontWeight(.bold)
                        
                        RegistroForm().environmentObject(model)
                    }.offset(y:-50)
                }

            }.ignoresSafeArea().background(Color("Background"))
                .onAppear {
                    UINavigationBar.appearance().tintColor = .white
                }.onDisappear {
                    UINavigationBar.appearance().tintColor = UIColor(named: "AccentColor")
                }
        }
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
    var formPassword: LocalizedStringKey = "form-title-signup-key"
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                HStack(alignment: .bottom) {
                    CustomTextFieldView(text: $username, name:  NSLocalizedString("form-name-login-key", comment:""))
                }
                            
                HStack(alignment: .bottom) {
                    CustomSecureFieldView(text: $password, name: NSLocalizedString("form-password-login-key", comment: ""))
                }
                            
                 HStack(alignment: .bottom) {
                     CustomSecureFieldView(text: $repeatPassword, name: NSLocalizedString("form-repeat-password-sigup-key", comment:""))
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
                    Text("form-title-signup-key")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 15)
                        .padding([.leading, .trailing], 25)
                        .cornerRadius(8)
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
                    Label("Introduzca las contraseñas", systemImage: "xmark.octagon")
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
                    Label("Contraseñas distintas", systemImage: "xmark.octagon")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.red)
                        .offset(x: 10, y:-40)
                }
            }.padding([.leading, .trailing], 20)
             .padding([.top, .bottom], 30)
        }.cornerRadius(20)
         .padding([.leading, .trailing])
    }
}


/*struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView().environmentObject(ViewModel())
    }
}*/
