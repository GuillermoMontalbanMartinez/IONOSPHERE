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
    var title: String
    @State var image: String
    
    @Binding var selected: String
    
    var body: some View {
        Button( action: {
            withAnimation(.spring()) {
                selected = title
            }
        }) {
            VStack(spacing: 6) {
                            

                Image(systemName: image ).resizable().renderingMode(.template)
                    .frame(width: 25, height: 25).foregroundColor(selected == title ? .accentColor : .gray)
                
                //Text(title).font(.caption).fontWeight(.bold).foregroundColor(Color.black.opacity( selected == title ? 0.6 : 0.2))
                
                /*if selected == title {
                    if ( title.contains("Home")) {
                        Text("Home").fontWeight(.bold).foregroundColor(.white)
                    } else {
                        Text(title).fontWeight(.bold).foregroundColor(.white)

                    }
                }*/
                
                /*ZStack {
                    CustomShape().fill(Color.clear).frame(width: 45, height: 6)
                    if ( selected == title ) {
                        CustomShape().fill(.white).frame(width: 45, height: 6, alignment: .center)
                    }
                }.padding(.bottom, 10)*/
                
                
            }.padding(.vertical,10).padding(.horizontal).offset(y: selected == title ? -10 : 0).onAppear {
                image = selected == title ? image + ".fill" : image
            }
        }
        

    }
}

/*struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(title: "home", image: "house.fill", selected: .constant("home"))
    }
}*/
