//
//  TabButton.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: rect.width , y: rect.height))
            path.move(to: CGPoint(x: rect.width , y: 0))
            path.move(to: CGPoint(x: 0 , y: rect.height))

            let mid = rect.width / 2
            path.move(to: CGPoint(x: mid-40 , y: rect.height))
            
            let to = CGPoint(x: mid , y: rect.height - 20)
            let control1 = CGPoint(x: mid - 15 , y: rect.height)
            let control2 = CGPoint(x: mid - 15, y: rect.height - 20)
            
            let to1 = CGPoint(x: mid + 40, y: rect.height)
            let control3 = CGPoint(x: mid + 15 , y: rect.height - 20)
            let control4 = CGPoint(x: mid + 15, y: rect.height)

            path.addCurve(to: to, control1: control1, control2: control2)
            path.addCurve(to: to1, control1: control3, control2: control4)

        }
    }
    
}

struct TabButton: View {
    @State var title: String
    @State var image: String
    @Binding var selected: String
    @Binding var logout: Bool
    
    var body: some View {
        Button( action: {
            withAnimation(.spring()) {
                selected = title
                if ( selected == "Cerrar sesión" ) {
                    logout = true
                }
                
            }
        }) {
            VStack(spacing: 6) {
                Image(systemName: "\(image)\(title == selected ? ".fill" : "")") .resizable().renderingMode(.template)
                    .frame(width: 25, height: 25).foregroundColor(Color.accentColor)
                Text(title == "EditarPerfil" ?  "Editar perfil" : title).font(.custom("Poppins-Regular", size: 10))
            }.padding(.vertical,10).padding(.horizontal)
        }
        

    }
}

/*struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(title: "home", image: "house.fill", selected: .constant("home"))
    }
}*/
