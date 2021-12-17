//
//  TabButton.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
    
}

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
            VStack(spacing: 6) {
                
                ZStack {
                    CustomShape().fill(Color.clear).frame(width: 45, height: 6)
                    if ( selected == title ) {
                        CustomShape().fill(Color.accentColor).frame(width: 45, height: 6, alignment: .center)
                    }
                }.padding(.bottom, 10)
                

            
                
                Image(systemName: image).resizable().renderingMode(.template)
                    .frame(width: 25, height: 25).foregroundColor(selected == title ? .accentColor : .gray)
                
                Text(title).font(.caption).fontWeight(.bold).foregroundColor(Color.black.opacity( selected == title ? 0.6 : 0.2))
                
                /*if selected == title {
                    if ( title.contains("Home")) {
                        Text("Home").fontWeight(.bold).foregroundColor(.white)
                    } else {
                        Text(title).fontWeight(.bold).foregroundColor(.white)

                    }
                }*/
                
                
            }.padding(.vertical,10).padding(.horizontal)//.background(Color.accentColor.opacity(selected == title ? 0.08 : 0)).clipShape(Capsule())
        }
        

    }
}

/*struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(title: "home", image: "house.fill", selected: .constant("home"))
    }
}*/
