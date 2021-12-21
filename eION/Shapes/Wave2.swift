//
//  Wave.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 17/12/21.
//

import SwiftUI

struct wave2: Shape {
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        // maxX, minY, maxY = de la figura no de la pantalla
        path.addLine(to: CGPoint(x: rect.maxX, y:  rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addCurve(to: CGPoint(x: rect.minX, y:  rect.maxY),
                      control1: CGPoint(x: rect.maxX*0.75, y:  rect.midY),
                      control2: CGPoint(x: rect.maxX*0.25, y:  rect.maxY*1.25))
        
        path.closeSubpath() //Para que se cierre la figura
        
        return path
        
    }
}

struct Wave_Previews: PreviewProvider {
    static var previews: some View {
        wave2().ignoresSafeArea().padding(.top, 0).frame(height: 300)
    }
}
