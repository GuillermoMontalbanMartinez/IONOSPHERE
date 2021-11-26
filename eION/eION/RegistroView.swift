//
//  RegistroView.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 24/11/21.
//

import SwiftUI

struct RegistroView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack {
                        Image("AppLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .clipShape(Circle())
                            .frame( alignment: .top)
                        Spacer()
                    }.padding(.top,-50)
              
                    VStack(spacing: 190) {
                        RegistroForm()
                        HStack() {
                            Text("¿Tienes una cuenta creada", tableName: "Login")
                            Button {
                             
                            } label: {
                                Text("Iniciar sesión", tableName: "Login")
                                    .foregroundColor(.black)
                                    .underline()
                                    .bold()
                            }
                        }.padding(.top,-150)
                    }
                }
            }
        }.navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

private struct RegistroForm: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                HStack(alignment: .bottom) {
                    Text("usuario", tableName: "Registro")
                       .frame(minWidth: 90, alignment: .leading)
                    VStack(spacing: 0) {
                       TextField("", text: $username)
                        Divider().background(.black)
                      }
                }
                            
                HStack(alignment: .bottom) {
                    Text("Contraseña ", tableName: "Registro")
                        .frame(minWidth: 90, alignment: .leading)
                    VStack(spacing: 0) {
                        SecureField("", text: $password)
                        Divider().background(.black)
                    }
                }
                            
                 HStack(alignment: .bottom) {
                    Text("Repetir contraseña", tableName: "Registro")
                        .frame(minWidth: 90, alignment: .leading)
                    VStack(spacing: 0) {
                        SecureField("", text: $repeatPassword)
                        Divider().background(.black)
                    }
                }
                Button {
                                
                } label: {
                    Text("Registrarse", tableName: "Login")
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 15)
                        .padding([.leading, .trailing], 25)
                        .background(.black)
                        .cornerRadius(8)
                        .shadow(color: Color(red: 13.0/255.0, green: 16.0/255.0, blue: 51.0/255.0).opacity(0.4), radius: 1, y: 4)
                }.padding(.bottom, 30)
            }.padding([.leading, .trailing], 20)
            .padding([.top, .bottom], 30)
        }.background()
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.4), radius: 4)
            .padding([.leading, .trailing])
            
    }
}

struct RegistroView_Previews: PreviewProvider {
    static var previews: some View {
        RegistroView()
    }
}
