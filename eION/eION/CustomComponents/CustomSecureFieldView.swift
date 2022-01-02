//
//  CustomSecureFieldView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 16/12/21.
//

import SwiftUI

struct CustomSecureFieldView: View {
    
    @Binding var text: String
    var name: String
    @State var isTapped = false
    @State var passOculta = true
    //var localizedStringKey: LocalizedStringKey
    
    var body: some View {
        HStack(alignment: .center,  spacing: 0) {
            HStack {
                if passOculta  {
                    SecureField("", text: $text).background(
                        Text(name)
                            .font(.custom("Poppins-Regular", size: 18))
                            .scaleEffect(isTapped ? 0.8 : 1)
                            .offset(x: isTapped ? -7 : 0, y: isTapped ? -20 : 0)
                            .foregroundColor(isTapped ? Color.accentColor : Color.gray)
                        , alignment: .leading)
                        .padding(.top, isTapped ? 15 : 0)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                isTapped = true
                            }
                        }.padding(.vertical, 12)
                        .padding(.horizontal)
                }
                else {
                    CustomTextFieldView(text: $text, name: name)
                }
                
                Spacer()
                PasswordEyeView(passOculta: $passOculta)

                
            }.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1).fill(Color.gray.opacity( passOculta ? 0.5 : 0 ))
            )
        
        }
    }
}

/*struct CustomSecureFieldView_Previews: PreviewProvider {
 static var previews: some View {
 CustomSecureFieldView()
 }
 }*/

struct PasswordEyeView: View {
    @Binding var passOculta: Bool
    var body: some View {
        Button {
            passOculta.toggle()
        } label: {
            if passOculta {
                Image(systemName: "eye.fill")
                
            } else {
                Image(systemName: "eye.slash.fill")
            }
        }.padding(20)
    }
}
