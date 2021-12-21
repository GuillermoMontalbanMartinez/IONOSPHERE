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
        GeometryReader { geo in
            ZStack {
                
                Circle().fill(Color.accentColor.opacity(0.4)).blur(radius: 15).frame(width: 400, height: 400).offset(x: 200, y: -100)
                
                Circle().fill(Color.accentColor.opacity(0.6)).blur(radius: 10).frame(width: 400, height: 400).offset(x: 200, y: 100)

                
                Circle().fill(Color.orange.opacity(0.4)).blur(radius: 10).frame(width: 200, height: 200).offset(x: -200, y: 100)
                
                Circle().fill(Color.orange.opacity(0.4)).blur(radius: 10).frame(width: 200, height: 200).offset(x: 50, y: 600)


            }.ignoresSafeArea()
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(height: 40)
    }
}
