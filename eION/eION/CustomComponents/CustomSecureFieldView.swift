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
    var body: some View {
        VStack(alignment: .leading,  spacing: 0) {
            SecureField("", text: $text).background(
                
                Text(name)
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
            
            Rectangle().fill(isTapped && !text.isEmpty ? Color.accentColor : Color.gray)
                .opacity(isTapped && !text.isEmpty ? 1 : 0.5)
                .frame(height: 1)
                .padding(.top, 10)
                

            
            
        }.padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(5)
    }
}

/*struct CustomSecureFieldView_Previews: PreviewProvider {
 static var previews: some View {
 CustomSecureFieldView()
 }
 }*/
