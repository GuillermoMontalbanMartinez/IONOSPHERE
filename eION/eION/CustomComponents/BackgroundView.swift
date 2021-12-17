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
                    wave(waveHeight: height, phase: Angle(degrees: (Double(geo.frame(in: .global).minY) + 200) * -1 * 0.8))
                        .foregroundColor(.accentColor)
                        .padding(.top, 300)
                    
                    /*LinearGradient(colors: [.accentColor.opacity(0.9), .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .mask( Circle().frame(width: 400).blur(radius: 5).offset(x:200, y: -200))
                    
                    LinearGradient(colors: [.purple.opacity(0.6), .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .mask( Circle().frame(width: 200).blur(radius: 20).offset(x:250, y: -150))
                    LinearGradient(colors: [.accentColor.opacity(0.3), .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .mask( Circle().frame(width: 100).blur(radius: 20).offset(x:-200, y: -120))
                    
                    
                    LinearGradient(colors: [.blue.opacity(0.3), .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .mask( Circle().frame(width: 200).blur(radius: 20).offset(x:-270, y: -100))*/
                    
                    
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
