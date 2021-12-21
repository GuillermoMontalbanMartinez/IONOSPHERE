//
//  BuscadorView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//

import SwiftUI

struct BuscadorView: View {
    @Binding var busqueda: String
    @State private var isEditing = false
    public var mensajeBuscador: String
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(busqueda.isEmpty
                                     ? Color(UIColor.gray).opacity(0.4)
                                     : Color(UIColor.gray).opacity(0.9))

                TextField(self.mensajeBuscador, text: $busqueda)
                    .font(.custom("Poppins-Regular", size: 18))
                    .onTapGesture {
                        self.isEditing = true
                    }
            }.padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
            
            
            if isEditing && !self.busqueda.isEmpty{
                Button(action: {
                    self.isEditing = false
                    self.busqueda = ""
                    
                }) {
                    Text("Cancel")
                        .font(.custom("Poppins-Regular", size: 18))

                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct BuscadorView_Previews: PreviewProvider {
    static var previews: some View {
        BuscadorView(busqueda: .constant("Prueba"), mensajeBuscador: "Prueba")
    }
}
