//
//  HomeView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 23/11/21.
//



import SwiftUI
import MessageUI


struct HomeView: View {
    @EnvironmentObject var vm : ViewModel
    @State private var isShareSheetShowing = false
    // @State private var tappedIndex = -1
    
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
                                                FilaPulso(index: index).environmentObject(vm)
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
                                                .frame(width: 200, height:200)
                                                .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.white, lineWidth: 5))
                                                .padding(.vertical)
                                            } else {
                                                Image("unknown")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(100)
                                                    .frame(width: 200, height:200)
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
}

struct ShareSheet: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    var items: [Any]
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    
}

struct FilaPulso: View
{
    @State var tappedIndex = 0
    var index: Int
    @State private var showingSheet = false
    @EnvironmentObject var vm : ViewModel
    
    @State var showPulsoView = false
    
    var body: some View{
        VStack {
            
            VStack {
                Image(systemName: "dot.radiowaves.left.and.right").resizable().foregroundColor(Color.accentColor).scaledToFit()
                Text(vm.pulsos[index].nombrePulso!).foregroundColor(Color.accentColor).font(.headline)
                Text(vm.pulsos[index].ubicacion ?? "").foregroundColor(Color.accentColor).font(.caption)
                
                Text(vm.pulsos[index].usuarioRelation?.nombre  ?? "").font(.caption)
            }.onTapGesture {
                showPulsoView = true
            }
            
            Button {
                showingSheet.toggle()
                tappedIndex = index
            } label: {
                Image(systemName: "square.and.arrow.up").foregroundColor(Color.black)
                Text("\(tappedIndex)").opacity(0).frame(width: 0, height: 0)

            }.sheet(isPresented: $showingSheet) {
                ShareSheet(items: [vm.pulsos[tappedIndex].nombrePulso!, vm.pulsos[tappedIndex].a03, vm.pulsos[tappedIndex].a27])
            }
            
        }.padding().frame(width: 150, height: 150)
            .background(Color("FilaTabla")).cornerRadius(100)
            .sheet(isPresented: $showPulsoView) {
                PulsoView(pulso: vm.pulsos[index])
            }
    }
}




/*struct HomeView_Previews: PreviewProvider {
 static var previews: some View {
 HomeView()
 }
 }*/


