//
//  HomeView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//



import SwiftUI


struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}


struct HomeView: View {
    @EnvironmentObject var vm : ViewModel
    @State private var isShareSheetShowing = false
    @State private var showingPopup = true
    
    var body: some View {
        ZStack {
             // LinearGradient(colors: [.accentColor.opacity(0.5), .white], startPoint: .topLeading, endPoint: .bottomTrailing)
            
            Circle().frame(width: 300).foregroundColor(Color.accentColor).blur(radius: 10).offset(x:-100, y: 50)
            Circle().frame(width: 100).foregroundColor(Color.accentColor.opacity(0.5)).blur(radius: 10).offset(x:150, y: 200)
            
            /*GeometryReader { geo in
                ZStack {
                    wave(waveHeight: 30, phase: Angle(degrees: (Double(geo.frame(in: .global).minY) + 45) * -1 * 0.7))
                        .foregroundColor(.yellow) .opacity(0.5)
                    
                    
                    wave(waveHeight: 30, phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 0.7))
                        .foregroundColor(.accentColor)
                }.padding(.top, 200)
            }*/

            ScrollView {
                VStack(spacing: 20) {
                    
                    Image("AppLogo").resizable().frame(width: 200, height: 200, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 30) {
                            VStack(alignment: .leading) {
                                
                                Text("Novedades").font(.title).fontWeight(.bold)
                                Text(Date().formatted())
                                
                            }
                            
                            if ( vm.pulsos.count > 0 ) {
                                HStack(spacing: 30) {
                                    ForEach(0..<3) { index in
                                        
                                        VStack {
                                            Image(systemName: "dot.radiowaves.left.and.right").foregroundColor(Color.accentColor)
                                            Text(vm.pulsos[index].nombrePulso!).foregroundColor(Color.accentColor).font(.headline)
                                            Text(vm.pulsos[index].ubicacion ?? "").foregroundColor(Color.accentColor).font(.caption)
                                            
                                            
                                            Button {
                                                shareButton()
                                                
                                            } label: {
                                                Image(systemName: "square.and.arrow.up").foregroundColor(Color.white)
                                            }
                                            
                                        }.padding().frame(width: 100, height: 100)
                                            .background(.ultraThinMaterial).cornerRadius(100)
                                        
                                    }
                                }
                            }

                        }
                        
                        Spacer()
                        
                    }.padding(.trailing, 40).padding(.leading, 40).padding(.bottom, 40).padding(.top, 40).frame(width: UIScreen.main.bounds.width-15).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous)).ignoresSafeArea().foregroundColor(.black)
                    
                    
                    VStack(alignment: .leading, spacing: 30) {
                        VStack(alignment: .leading) {
                            Text("Otros usuarios").font(.title).fontWeight(.bold)
                            
                        }
                        HStack(spacing: 30) {
                            ForEach(0..<vm.usuarios.count) { index in
                                VStack {
                                    Text(vm.usuarios[index].nombre ?? "")
                                }.padding().frame(width: 100, height: 100).cornerRadius(100)
                            }
                        }
                    }.padding(.trailing, 40).padding(.leading, 40).padding(.bottom, 40).padding(.top, 40).frame(width: UIScreen.main.bounds.width-15).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous)).ignoresSafeArea().foregroundColor(.black)
                }
                
            }
        }.ignoresSafeArea()
        
        
    }
    
    func shareButton() {
        isShareSheetShowing.toggle()
        
        let url = URL(string: "https://apple.com")
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}




/*struct HomeView_Previews: PreviewProvider {
 static var previews: some View {
 HomeView()
 }
 }*/
