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
        VStack {
            VStack {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .clipShape(Circle())
                    .frame( alignment: .top)
                    
            }.padding(40)
            .offset(y:-120)
            
            VStack(spacing: 15) {
                RegistroForm().environmentObject(model)
            }.offset(y:-140)
        }
    }
}

private struct RegistroForm: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    @State var emptyUsername: Bool = false
    @State var emptyPassword: Bool = false
    @State var emptyRepeatPassword: Bool = false
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                HStack(alignment: .bottom) {
                    Text("Usuario", tableName: "Registro")
                       .frame(minWidth: 90, alignment: .leading)
                       .disableAutocorrection(true)
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
                    emptyUsername = false
                    emptyPassword = false
                    emptyRepeatPassword = false
                    if username.isEmpty {
                        emptyUsername = true
                    } else if password.isEmpty{
                        emptyPassword = true
                    } else if repeatPassword.isEmpty {
                        emptyRepeatPassword = true
                    } else {
                        do {
                            try model.addUsuario(nombre: username, password: password)
                        } catch eION.ViewModel.error.datoRepetido {
                            print("Usuario existente en la base de datos")
                        } catch {
                            print("Error desconocido")
                        }
                    }

                } label: {
                    Text("Registrarse", tableName: "Login")
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 15)
                        .padding([.leading, .trailing], 25)
                        .background(.black)
                        .cornerRadius(8)
                        .shadow(color: Color(red: 13.0/255.0, green: 16.0/255.0, blue: 51.0/255.0).opacity(0.4), radius: 1, y: 4)
                }.padding(.bottom, 30)
                
                if emptyPassword && emptyRepeatPassword {
                    Text("Introduzca la contraseña").foregroundColor(.red)
                        .offset(x:10, y: -185)
                    Text("Repite la contraseña")
                        .foregroundColor(.red)
                        .offset(x: 10, y: -185)
                }
                
                if emptyUsername {
                    Text("Introduce el usuario")
                        .foregroundColor(.red)
                        .offset(x: 10,y: -235)
                }
                
                if emptyPassword {
                    Text("Introduce la contraseña")
                        .foregroundColor(.red)
                        .offset(x: 10,y: -185)
                }
                
                if emptyRepeatPassword {
                    Text("Repite la contraseña")
                        .foregroundColor(.red)
                        .offset(x: 10,y: -140)
                }

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
        RegistroView().environmentObject(ViewModel())
    }
}
