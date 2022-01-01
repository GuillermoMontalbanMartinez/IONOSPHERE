//
//  CustomTextFieldView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 16/12/21.
//

import SwiftUI

struct CustomTextFieldView: View {

    //var localizedStringKey: String
    @Binding var text: String
    var name: String
    @State var isTapped = false

    var body: some View {

        VStack(alignment: .leading,  spacing: 0) {
            TextField("", text: $text) { (status) in
                // Se ejecuta cuando se hace click en el textfield
                if status {
                    withAnimation(.easeIn) {
                        isTapped = true
                    }
                }
            } onCommit: {
                // Se ejecuta cuando se envia
                if text.isEmpty {
                    withAnimation(.easeIn) {
                        isTapped = false
                    }
                }
            }.padding(.top, isTapped ? 15 : 0)
            .background(

                Text(name)
                    .font(.custom("Poppins-Regular", size: 18))
                    .scaleEffect(isTapped ? 0.8 : 1)
                    .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                    .foregroundColor(isTapped ? Color.accentColor : Color.gray)
                , alignment: .leading)

        }.padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(5)
    }
}


/*
import SwiftUI

struct CustomTextFieldView: View {
    
    @Binding var text: String
    var name: String
    @State var isTapped = false
    var body: some View {
        
        VStack(alignment: .leading,  spacing: 0) {
            //TextField("", text: $text) { (status) in
            TextField("form-name-login-key", text: $text) { (status) in
                // Se ejecuta cuando se hace click en el textfield
                if status {
                    withAnimation(.easeIn) {
                        isTapped = true
                    }
                }
            } onCommit: {
                // Se ejecuta cuando se envia
                if text.isEmpty {
                    withAnimation(.easeIn) {
                        isTapped = false
                    }
                }
            }.padding(.top, isTapped ? 15 : 0)
            .background(
                
                Text(name)
                    .font(.custom("Poppins-Regular", size: 18))
                    .scaleEffect(isTapped ? 0.8 : 1)
                    .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                    .foregroundColor(isTapped ? Color.accentColor : Color.gray)
                , alignment: .leading)
            
            /*Rectangle().fill(isTapped ? Color.accentColor : Color.gray)
                .opacity(isTapped ? 1 : 0.5)
                .frame(height: 1)
                .padding(.top, 10)*/
            
        }.padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(5)
    }
}

/*struct CustomTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextFieldView()
    }
}*/

*/
