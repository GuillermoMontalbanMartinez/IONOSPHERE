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
                    }.padding(40)
                    
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
                                     Text("Registrate", tableName: "Login")
                                         .font(.custom("Poppins-Regular", size: 18))
                                         .foregroundColor(.black)
                                        .underline()
                                        .bold()
                                }
                                NavigationLink(destination: RegistroView(), isActive: $showView) {
                                        EmptyView()
                                }
                            }
                        }.offset(y:-100)
                    }
                }.ignoresSafeArea().background(BackgroundView(height: 0))
            }
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
        if ( vm.loading ) {
            ProgressView().foregroundColor(.white)
        } else {
            VStack {
                VStack(spacing: 30) {
                    Text("form-title-login-key").font(.custom("Poppins-SemiBold", size: 28)).fontWeight(.bold).foregroundStyle(LinearGradient(colors: [.accentColor, .gray], startPoint: .top, endPoint: .bottom))
                    HStack(alignment: .bottom) {
                        CustomTextFieldView(text: $username, name:"form-name-login-key")
                    }
                
                    HStack(alignment: .bottom) {
                        CustomSecureFieldView(text: $password, name:"form-password-login-key")
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
                        .padding()
                }.buttonStyle(CustomButton())
            }.background(.ultraThinMaterial)
             .cornerRadius(20)
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
