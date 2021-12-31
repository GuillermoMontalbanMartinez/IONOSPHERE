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
    
    var body: some View {
        HStack(alignment: .center,  spacing: 0) {
            if passOculta  {
                HStack {
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
                        }
                }.padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(5)
            } else {
                CustomTextFieldView(text: $text, name: name)
                
            }
            
            

            
            Button {
                passOculta.toggle()
            } label: {
                if passOculta {
                    Image(systemName: "eye.fill")

                } else {
                    Image(systemName: "eye.slash.fill")
                }
            }.padding(20)
            
            /*Rectangle().fill(isTapped && !text.isEmpty ? Color.accentColor : Color.gray)
                .opacity(isTapped && !text.isEmpty ? 1 : 0.5)
                .frame(height: 1)
                .padding(.top, 10)*/
 
            
        }.background(Color.white).cornerRadius(5)
    }
}

/*struct CustomSecureFieldView_Previews: PreviewProvider {
 static var previews: some View {
 CustomSecureFieldView()
 }
 }*/
