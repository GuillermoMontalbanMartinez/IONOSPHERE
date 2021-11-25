//
//  FilaTablaview.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//

import SwiftUI

struct FilaTablaview: View {
    var tituloIzq: String
    var tituloDer: String? //Puede no existir
    var body: some View {
        HStack {
            Text(tituloIzq)
            Spacer()
            if ( tituloDer != nil) {
                Text(tituloDer!).font(.caption).foregroundColor(.gray)
            }

        }
            .padding()
            .frame(width: 280)
            .background(Color("FilaTabla"))
            .cornerRadius(20)
    }
}

struct FilaTablaview_Previews: PreviewProvider {
    static var previews: some View {
        FilaTablaview(tituloIzq: "Prueba", tituloDer: "Prueba")
    }
}
