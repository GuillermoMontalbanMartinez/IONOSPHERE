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
        ZStack {
            GeometryReader { geo in
                NavigationView {
                    VStack {
                        VStack {
                            wave(waveHeight: 40, phase: Angle(degrees: (Double(geo.frame(in: .global).minY) + 100) * -1 * 0.9)).fill(Color.accentColor)
                                .rotationEffect(Angle(degrees:180))
                                .frame(height: 300)
                        }.ignoresSafeArea().frame(width: 400, height: 350)
                            .background(
                                wave(waveHeight: 30, phase: Angle(degrees: (Double(geo.frame(in: .global).minY) + 45) * -1 * 0.7)).fill(Color("Secondary"))
                                    .rotationEffect(Angle(degrees:180))
                                    .frame(height: 350)
                            )
                        //Spacer()

                        GeometryReader { geo in
                            VStack(spacing: 0) {
                                Spacer()
                                LoginForm(logeado: $logeado)
                                
                                HStack() {
                                    Text("form-account-login-key").foregroundColor(.black)
                                        .font(.custom("Poppins-Regular", size: 18))
                                    Button {
                                        showView = true
                                    } label: {
                                        Text("form-title-signup-key")
                                            .font(.custom("Poppins-Regular", size: 18))
                                            .foregroundColor(.black)
                                            .underline()
                                            .bold()
                                    }
                                    NavigationLink(destination: RegistroView(), isActive: $showView) {
                                        EmptyView()
                                    }
                                }
                            }.offset(y:-50)
                        }
                    }.ignoresSafeArea()
                }
            }
        }.ignoresSafeArea().onAppear {
            UINavigationBar.appearance().tintColor = .white
        }.onDisappear {
            UINavigationBar.appearance().tintColor = UIColor(named: "AccentColor")
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
    
    var body: some View {
        if ( vm.loading ) {
            ProgressView().foregroundColor(.white)
        } else {
            VStack {
                VStack(spacing: 30) {
                    Text("form-title-login-key").font(.custom("Poppins-Regular", size: 38)).fontWeight(.bold)
                    
                    HStack(alignment: .bottom) {
                        CustomTextFieldView(text: $username, name:NSLocalizedString("form-name-login-key", comment: ""))
                    }
                    
                    HStack(alignment: .bottom) {
                        CustomSecureFieldView(text: $password, name: NSLocalizedString("form-password-login-key", comment: ""))
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
                    Text("form-button-signin-login-key")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.white)
                        .padding()
                }.buttonStyle(CustomButton())
            }
            .padding([.leading, .trailing])
            
            
            if emptyUsername && emptyPassword {
                Label("Introduzca el usuario y la contraseña", systemImage: "xmark.octagon")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.red)
                    .offset(x: 10, y:-40)
            } else if emptyUsername {
                Label("Introduzca el nombre del usuario", systemImage: "xmark.octagon")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.red)
                    .offset(x: 10, y:-180)
            } else if emptyPassword {
                Label("Introduzca la contraseña", systemImage: "xmark.octagon")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.red)
                    .offset(x: 10, y:-130)
            }
            
            if failLogin {
                Label("Datos incorrectos", systemImage: "xmark.octagon")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.red)
                    .offset(x: 10, y:-40)
            }
        }
    }
}

/*struct LoginView_swift_Previews: PreviewProvider {
 static var previews: some View {
 LoginView(logeado: .constant(false))
 .previewInterfaceOrientation(.portrait)
 }
 }*/
