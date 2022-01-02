//
//  PerfilUsuarioView.swift
//  eION
//
//  Created by Jorge Mora Campoy on 21/12/21.
//

import SwiftUI
import MessageUI

struct PerfilUsuarioView: View {
    @EnvironmentObject var vm : ViewModel
    var usuario : Usuario
    @State var pulsos: [Pulso] = []
    var body: some View {
        ZStack {
            GeometryReader { geo in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        VStack(alignment: .center, spacing: 20) {
                            VStack(alignment: .center, spacing: 30) {
                                VStack(alignment: .center) {
                                    Text(usuario.nombre ?? "Nombre usuario").font(.custom("Poppins-Regular", size: 28)).foregroundColor(.black)
                                }
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
                                        .frame(width: 250, height:250)
                                        .padding(.vertical)
                                }
                            }
                        }.padding(.trailing, 40).padding(.leading, 40).padding(.bottom, 40).padding(.top, 40).frame(width: UIScreen.main.bounds.width-15)
                        PulsosUsuario(pulsos: pulsos)
                    }.offset(y: 100)
                }.frame(maxWidth: .infinity).onAppear{
                    self.pulsos = vm.getPulsosUsuario(usuario: usuario)
                }
            }
        }.ignoresSafeArea()
    }
}

struct PulsosUsuario: View {
    var pulsos: [Pulso]
    var body: some View{
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("Sus pulsos", comment: "")).font(.custom("Poppins-Regular", size: 28)).fontWeight(.bold).foregroundColor(.black)
            }

            }.foregroundStyle(LinearGradient(colors: [.accentColor, .gray], startPoint: .top, endPoint: .bottom))
            if ( pulsos.count > 0 ) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(0 ..< pulsos.count) { index in
                            FilaPulsoUsuario(pulso: pulsos[index])
                        }
                    }
                }.frame(maxWidth: .infinity)
            } else {
                Text("Todavía no tiene pulsos").font(.custom("Poppins-Regular", size: 20)).fontWeight(.bold).foregroundColor(.black)

            }
        }
    }


struct FilaPulsoUsuario: View
{
    var pulso: Pulso
    @State private var showingSheet = false
    @EnvironmentObject var vm : ViewModel
    @State var showPulsoView = false
    var body: some View{
        VStack {
            
            VStack {
                Image(systemName: "waveform").resizable().scaledToFit()
                    .foregroundStyle(LinearGradient(colors: [.accentColor, .gray], startPoint: .top, endPoint: .bottom))
                Text(pulso.nombrePulso ?? "").foregroundColor(Color.accentColor).font(.system(size: 18, weight: .regular, design: .rounded))
                Text(pulso.ubicacion ?? "").foregroundColor(Color.accentColor).font(.system(size: 14, weight: .regular, design: .rounded))
                Text(pulso.usuarioRelation?.nombre  ?? "").font(.caption)
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
            ShareSheetUsuario(items: [pulso.nombrePulso ?? "", pulso.a03, pulso.a27])
            
        }.padding().frame(width: 150, height: 150)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .sheet(isPresented: $showPulsoView) {
                PulsoView(pulso: pulso)
            }
    }
}


struct ShareSheetUsuario: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    var items: [Any]
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
}

/*struct PerfilUsuarioView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilUsuarioView(usuario : ViewModel().usuarios[0])
    }
}*/
