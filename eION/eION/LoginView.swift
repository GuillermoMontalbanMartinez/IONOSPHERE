//
//  LoginView.swift.swift
//  eION
//
//  Created by Guillermo Montalban Martinez on 24/11/21.
//

import SwiftUI

struct LoginView: View {
    @State var showView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .clipShape(Circle())
                        .frame( alignment: .top)
                }.offset(y:-140)
                
                VStack(spacing: 15) {
                    LoginForm()
                    HStack() {
                        Text("¿No tienes cuenta?", tableName: "Login")
                         Button {
                             showView = true
                         } label: {
                             Text("Registrate", tableName: "Login")
                                .foregroundColor(.black)
                                .underline()
                                .bold()
                        }
                        NavigationLink(destination: RegistroView(), isActive: $showView) {
                                EmptyView()
                        }
                    }
                }.offset(y:-120)
            }
        }
    }
}

private struct LoginForm: View {
    @State var username:String = ""
    @State var password:String = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 30) {
                HStack(alignment: .bottom) {
                    Text("Nombre", tableName: "Login")
                        .frame(minWidth: 90, alignment: .leading)
                        .disableAutocorrection(true)
                    VStack(spacing: 0) {
                        TextField("", text: $username)
                        Divider()
                            .background(.black)
                    }
                }
            
                HStack(alignment: .bottom) {
                    Text("Contraseña", tableName: password)
                        .frame(minWidth: 90, alignment: .leading)
                    VStack(spacing: 0) {
                        SecureField("", text: $password)
                        Divider()
                            .background(.black)
                    }
                }
   
            }.padding([.leading, .trailing], 20)
             .padding([.top, .bottom], 30)
            
            Button {
                            
            } label: {
                Text("Iniciar sesión", tableName: "Login")
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 15)
                    .padding([.leading, .trailing], 25)
                    .background(.black)
                    .cornerRadius(8)
                    .shadow(color: Color(red: 13.0/255.0, green: 16.0/255.0, blue: 51.0/255.0).opacity(0.4), radius: 1, y: 4)
            }.padding(.bottom, 30)
        }.background()
         .cornerRadius(20)
         .shadow(color: .gray.opacity(0.4), radius: 4)
         .padding([.leading, .trailing])
    }
}

struct LoginView_swift_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
.previewInterfaceOrientation(.portrait)
    }
}
