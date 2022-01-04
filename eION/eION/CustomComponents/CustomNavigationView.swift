//
//  CustomNavigationView.swift
//  eION
//
//  Created by Cristian Casado on 8/12/21.
//

import SwiftUI

struct CustomNavigationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var title : String = "Prueba"
    var botones : Bool = true
    var destino : Bool = true
    @Binding var anadir : Bool
    
    var body: some View {
        VStack{
            HStack{
                if(destino){
                
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("Color"))
                            .frame(width: 30, height: 30)
                    }

                }
                
                Text(title)
                    .font(.custom("Poppins-Regular", size: 35))

                Spacer()
                if (botones){
                    Button(action: {anadir.toggle()}){
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.accentColor)
                    }
                }
            }
        }.padding([.trailing,.leading])
        
    }
}

/*struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView(anadir: .constant(false))
    }
}*/
