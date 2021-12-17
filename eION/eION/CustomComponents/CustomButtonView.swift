//
//  CustomButton.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 15/12/21.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .background(Color.white)
            .cornerRadius(10)
        // .foregroundColor(configuration.isPressed ? .gray : .white)
            .padding()
            .padding(.bottom, 30)
            //.background(isEnabled ? Color.accentColor : .gray)
            .padding([.leading, .trailing])
            
            
        
    }
}



