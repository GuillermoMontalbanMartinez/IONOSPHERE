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

                    VStack {
                        RadialGradient(gradient: Gradient(colors: [.black, .accentColor]), center: .center, startRadius: 50, endRadius: 100).blur(radius: 50).frame(width: 300, height: 300).offset(x:0, y: 100).clipShape(Circle())
                    }.offset(x:150, y: -400)

                    VStack {
                        RadialGradient(gradient: Gradient(colors: [.accentColor, .accentColor]), center: .center, startRadius: 50, endRadius: 100).blur(radius: 50).frame(width: 200, height: 200).offset(x:0, y: 90).clipShape(Circle())
                    }.offset(x:100, y: 200)

                    
                    VStack {
                        RadialGradient(gradient: Gradient(colors: [.accentColor, .accentColor]), center: .center, startRadius: 50, endRadius: 100).blur(radius: 50).frame(width: 100, height: 100).offset(x:10, y: 10).clipShape(Circle())
                    }.offset(x:170, y:-100)
                    
                    VStack {
                        RadialGradient(gradient: Gradient(colors: [.accentColor, .accentColor]), center: .center, startRadius: 50, endRadius: 100).blur(radius: 50).frame(width: 70, height: 70).offset(x:01, y: 01).clipShape(Circle())
                    }.offset(x:50, y:-150)
                    
   
                    VStack {
                        RadialGradient(gradient: Gradient(colors: [.white, .accentColor]), center: .center, startRadius: 50, endRadius: 100).blur(radius: 50).frame(width: 250, height: 2500).offset(x:0, y: 150).clipShape(Circle())
                    }.offset(x:150, y: -300)
                    



                    


                    /*wave(waveHeight: 30, phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 0.7))
                        //.foregroundColor(.accentColor)
                        .foregroundStyle(LinearGradient(gradient: Gradient(stops: [.init(color: Color.indigo, location: 0), .init(color: Color.accentColor, location: 1)]), startPoint: UnitPoint(x: 0.5, y: -1.0), endPoint: UnitPoint(x: -1, y: -0.1)))
                        .padding(.top, 300)*/
                    
                }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
            }
        }.ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(height: 40)
    }
}
