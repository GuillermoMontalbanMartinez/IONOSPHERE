//
//  TabButton.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI

struct TabButton: View {
    var title: String
    var image: String
    
    @Binding var selected: String
    
    var body: some View {
        Button( action: {
            withAnimation(.spring()) {
                selected = title
            }
        }) {
            HStack(spacing: 10) {
                
                Image(systemName: image).resizable().renderingMode(.template)
                    .frame(width: 25, height: 25).foregroundColor(.white)
                
                if selected == title {
                    if ( title.contains("Home")) {
                        Text("Home").fontWeight(.bold).foregroundColor(.white)
                    } else {
                        Text(title).fontWeight(.bold).foregroundColor(.white)

                    }
                }
                
                
            }.padding(.vertical,10).padding(.horizontal).background(Color.white.opacity(selected == title ? 0.08 : 0)).clipShape(Capsule())
        }
        

    }
}

/*struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(title: "home", image: "house.fill", selected: .constant("home"))
    }
}*/
