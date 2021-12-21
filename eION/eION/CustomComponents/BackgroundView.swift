//
//  BackgroundView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 17/12/21.
//

import SwiftUI

struct BackgroundView: View {
    
    var height: CGFloat
    var body: some View {
        VStack {
            GeometryReader { geo in
                ZStack {
                
                    /*wave(waveHeight: height, phase: Angle(degrees: (Double(geo.frame(in: .global).minY) + 200) * -1 * 0.8))
                        .foregroundStyle(LinearGradient(colors: [.accentColor], startPoint: .top, endPoint: .bottom))
                        .padding(.top, 300)*/
                    
                    
                    Circle().frame(width: 150, height: 150).offset(x:-150, y: -100)
                        .foregroundColor(.accentColor).blur(radius: 20)
                    
                    
                    Circle().frame(width: 300, height: 300).offset(x:150, y: 400)
                        .foregroundColor(.accentColor).blur(radius: 20)
                    
                    
                    
                    Circle().frame(width: 150, height: 150).offset(x:-200, y: 500)
                        .foregroundColor(.accentColor).blur(radius: 20)


                    /*wave(waveHeight: 30, phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 0.7))
                        //.foregroundColor(.accentColor)
                        .foregroundStyle(LinearGradient(gradient: Gradient(stops: [.init(color: Color.indigo, location: 0), .init(color: Color.accentColor, location: 1)]), startPoint: UnitPoint(x: 0.5, y: -1.0), endPoint: UnitPoint(x: -1, y: -0.1)))
                        .padding(.top, 300)*/
                    
                }
                
            }
        }.ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(height: 40)
    }
}
