//
//  PerfilUsuarioView.swift
//  eION
//
//  Created by Jorge Mora Campoy on 21/12/21.
//

import SwiftUI

struct PerfilUsuarioView: View {
    
    var usuario : Usuario
    
    var body: some View {
    
        ZStack {
            GeometryReader { geo in
                
                BackgroundView(height: 40)//.blur(radius: 20)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                       
                        VStack(alignment: .center, spacing: 20) {
                       
                            VStack(alignment: .center, spacing: 30) {
                                VStack(alignment: .center) {
                                    
                                    Text(usuario.nombre ?? "Nombre usuario").font(.system(size: 28, weight: .bold, design: .rounded))
                                   
                                    
                                }.foregroundStyle(LinearGradient(colors: [.accentColor, .gray], startPoint: .top, endPoint: .bottom))
                                
                                if usuario.foto != nil {
                                    Image(uiImage: UIImage(data: usuario.foto ?? Data()) ?? UIImage())
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(20)
                                        .frame(width: 250, height:250)
                                        .padding(.vertical)
                                } else {
                                    Image("unknown")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(20)
                                        .frame(width: 300, height:300)
                                        .padding(.vertical)
                                    
                                }
                                
                            }
                            
                            
                        }.padding(.trailing, 40).padding(.leading, 40).padding(.bottom, 40).padding(.top, 40).frame(width: UIScreen.main.bounds.width-15).background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous)).ignoresSafeArea().foregroundColor(.black)
                        
                        
                        VStack(alignment: .leading, spacing: 30) {
                            VStack(alignment: .leading) {
                                Text("Sus pulsos").font(.largeTitle).fontWeight(.bold)
                            }.foregroundStyle(LinearGradient(colors: [.accentColor, .gray], startPoint: .top, endPoint: .bottom))
                           
                            
                          
                        }.padding(.trailing, 40).padding(.leading, 40).padding(.bottom, 40).padding(.top, 40).frame(width: UIScreen.main.bounds.width-15).background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous)).ignoresSafeArea().foregroundColor(.black)
                        
                    
                        
                    }.offset(y: 200)
                }.frame(maxWidth: .infinity)
            }
        }.ignoresSafeArea().background(Color("Background"))
    }
}

/*struct PerfilUsuarioView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilUsuarioView(usuario : ViewModel().usuarios[0])
    }
}*/
