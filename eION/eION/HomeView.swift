//
//  HomeView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//



import SwiftUI


struct HomeView: View {
    @EnvironmentObject var vm : ViewModel
    @State private var isShareSheetShowing = false
    @State private var showingPopup = true
    
    var body: some View {
        ZStack {
            GeometryReader { geo in

                BackgroundView(height: 40)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        
                        Image("AppLogo").resizable().frame(width: 200, height: 200, alignment: .center)
                        
                        VStack(alignment: .center, spacing: 20) {
                            
                            VStack(alignment: .leading, spacing: 30) {
                                VStack(alignment: .leading) {
                                    
                                    Text("Novedades").font(.largeTitle).fontWeight(.bold)
                                    Text("Hoy, \(Date().formatted())")
                                    
                                }
                                
                                if ( vm.pulsos.count > 0 ) {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 30) {
                                            ForEach(0..<3) { index in
                                                VStack {
                                                    Image(systemName: "dot.radiowaves.left.and.right").foregroundColor(Color.accentColor)
                                                    Text(vm.pulsos[index].nombrePulso!).foregroundColor(Color.accentColor).font(.headline)
                                                    Text(vm.pulsos[index].ubicacion ?? "").foregroundColor(Color.accentColor).font(.caption)
                                                    
                                                    
                                                    Button {
                                                        shareButton()
                                                        
                                                    } label: {
                                                        Image(systemName: "square.and.arrow.up").foregroundColor(Color.black)
                                                    }
                                                    
                                                }.padding().frame(width: 100, height: 100)
                                                    .background(Color("FilaTabla")).cornerRadius(100)
                                                
                                            }
                                        }
                                        
                                    }.frame(maxWidth: .infinity)
                                }
                                
                                Text("Observa los pulsos creados en los últimos días y compártelos con tus amigos")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                            }
                            
                            Spacer()
                            
                        }.padding(.trailing, 40).padding(.leading, 40).padding(.bottom, 40).padding(.top, 40).frame(width: UIScreen.main.bounds.width-15).background(Color.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous)).ignoresSafeArea().foregroundColor(.black)
                        
                        
                        VStack(alignment: .leading, spacing: 30) {
                            VStack(alignment: .leading) {
                                Text("Otros usuarios").font(.largeTitle).fontWeight(.bold)
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 30) {
                                    ForEach(0..<vm.usuarios.count) { index in
                                        VStack(spacing: 0) {
                                            
                                            Text(vm.usuarios[index].nombre ?? "")
                                            if vm.usuarios[index].foto != nil {
                                                Image(uiImage: UIImage(data: vm.usuarios[index].foto ?? Data()) ?? UIImage())
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(100)
                                                .frame(width: 100, height:100)
                                                .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.white, lineWidth: 5))
                                                .padding(.vertical)
                                            } else {
                                                Image("unknown")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(100)
                                                    .frame(width: 100, height:100)
                                                    .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.white, lineWidth: 5))
                                                    .padding(.vertical)
                                            }
                                                
                                        }.padding().cornerRadius(100)
                                    }
                                }
                            }.frame(maxWidth: .infinity)
                            
                            Text("Otros usuarios que también están compartiendo sus pulsos")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }.padding(.trailing, 40).padding(.leading, 40).padding(.bottom, 40).padding(.top, 40).frame(width: UIScreen.main.bounds.width-15).background(Color.white, in: RoundedRectangle(cornerRadius: 20, style: .continuous)).ignoresSafeArea().foregroundColor(.black)
                        
                        Spacer()
                        
                    }
                }.frame(maxWidth: .infinity)
            }
        }.ignoresSafeArea().background(Color("Background"))
        
        
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
