//
//  DiagramaView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI

struct DiagramaView: Shape {
       
    var lista: [Double]
    var index: Int
        
    func path(in rect:CGRect) -> Path {
        var arc = Path()
        var counter = 0.0;
        var sumDegree = 0.0;
        
        for item in lista  {
            counter = counter + item
        }
        
        let value = ((lista[index]/counter)*100)*360/100

        
        for i in 0..<index{
            sumDegree = sumDegree + ((lista[i]/counter)*100)*360/100
        }
        

        arc.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 100, startAngle: .degrees(sumDegree), endAngle: .degrees(sumDegree+value), clockwise: false)                   
        arc.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        arc.closeSubpath()
        
        return arc
        
    }
}

struct DiagramaView_Previews: PreviewProvider {
    static var previews: some View {
        DiagramaView(lista:[1.0,2.0], index: 1)
    }
}
