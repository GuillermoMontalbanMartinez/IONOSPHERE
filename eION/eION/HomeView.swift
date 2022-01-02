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
    @State var pulsos: [Pulso] = []
    
    var body: some View {
        GeometryReader { geo in

            ZStack {
                Circle().fill(Color("Secondary")).frame(width: 300, height: 300).offset(x: 200, y: 0)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        Spacer()
                        if pulsos.count > 0 {
                            Novedades(pulsos: pulsos).padding(.trailing, 40).padding(.leading, 40).padding(.bottom, 40).padding(.top, 40).frame(width: UIScreen.main.bounds.width-15).ignoresSafeArea().foregroundColor(.black)
                            
                        }
                        if ( vm.usuarios.count > 1 ) {
                            Usuarios().environmentObject(vm)
                        }
                        Spacer()
                    }
                }.frame(maxWidth: .infinity)
                    .onAppear {
                        self.pulsos = vm.obtenerPulsos()
                    }
            }
        }.ignoresSafeArea()
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    var items: [Any]
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
}


struct Novedades: View {
    var pulsos: [Pulso]
    var body: some View{
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("form-title-novedades-key", comment: "")).font(.custom("Poppins-Regular", size: 28))
                HStack {
                    Text(NSLocalizedString("form-hoy-key", comment: "")).font(.custom("Poppins-Regular", size: 18))
                    Text("\(Date().formatted())").font(.custom("Poppins-Regular", size: 18))
                }
                
            }
            if ( pulsos.count > 0 ) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(0 ..< pulsos.count) { index in
                            FilaPulso(pulso: pulsos[index])
                        }
                    }
                }.frame(maxWidth: .infinity)
            }
            Text(NSLocalizedString("form-observa-pulsos-creados-key", comment: ""))
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.black)
        }
    }
}

struct Usuarios: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View{
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("form-otros-usuarios-key", comment: "")).font(.custom("Poppins-Regular", size: 28)).fontWeight(.bold)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(vm.usuarios) { usuario in
                        FilaUsuario(usuario: usuario)
                    }
                }
            }.frame(maxWidth: .infinity)
            Text(NSLocalizedString("form-otros-usuaarios-comparten-key", comment: "")).font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.black)
        }.padding(.trailing, 40).padding(.leading, 40).padding(.bottom, 40).padding(.top, 40).frame(width: UIScreen.main.bounds.width-15).ignoresSafeArea().foregroundColor(.black)
    }
}

struct FilaUsuario : View{
    var usuario : Usuario
    @State var isSheetPerfilUsuario : Bool = false
    var body: some View{
        VStack(spacing: 0) {
            if usuario.foto != nil {
                Image(uiImage: UIImage(data: usuario.foto ?? Data()) ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(width: 150, height:150)
                    .padding(.vertical).onTapGesture(perform: {
                        isSheetPerfilUsuario.toggle()
                    }).sheet(isPresented: $isSheetPerfilUsuario){
                        PerfilUsuarioView(usuario:usuario)
                    }
            } else {
                Image("unknown")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                    .frame(width: 150, height:150)
                    .padding(.vertical).onTapGesture(perform: {
                        isSheetPerfilUsuario.toggle()
                    }).sheet(isPresented: $isSheetPerfilUsuario){
                        PerfilUsuarioView(usuario:usuario)
                    }
            }
            Text(usuario.nombre ?? "").font(.custom("Poppins-Regular", size: 16))
            
        }.padding().cornerRadius(100)
    }
    
}

struct FilaPulso: View
{
    var pulso: Pulso
    @State private var showingSheet = false
    @EnvironmentObject var vm : ViewModel
    @State var showPulsoView = false
    var body: some View{
        VStack {
            VStack {
                Image(systemName: "waveform").resizable().scaledToFit().foregroundColor(.white)
                Text(pulso.nombrePulso ?? "").foregroundColor(Color.white).font(.system(size: 18, weight: .regular, design: .rounded))
                Text(pulso.ubicacion ?? "").foregroundColor(Color.white).font(.system(size: 14, weight: .regular, design: .rounded))
                Text(pulso.usuarioRelation?.nombre  ?? "").font(.caption).foregroundColor(.white)
            }.onTapGesture {
                showPulsoView = true
            }.contextMenu {
                VStack {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Text(NSLocalizedString("form-homeview-compartir", comment: ""))
                        Image(systemName: "square.and.arrow.up").foregroundColor(Color.black)
                    }
                }
            }
        }.sheet(isPresented: $showingSheet) {
            ShareSheet(items: [pulso.nombrePulso ?? "", pulso.a03, pulso.a27])
            
        }.padding().frame(width: 150, height: 150)
            .background(Color.accentColor)
            .cornerRadius(20)
            .sheet(isPresented: $showPulsoView) {
                PulsoView(pulso: pulso)
            }
    }
}

/*struct HomeView_Previews: PreviewProvider {
 static var previews: some View {
 HomeView()
 }
 }*/


