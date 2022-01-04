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
    var body: some View {
        ZStack {
            Color("Background")
            GeometryReader { geo in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        VStack(alignment: .center, spacing: 20) {
                            VStack(alignment: .center, spacing: 30) {
                                VStack(alignment: .center) {
                                    Text(usuario.nombre ?? "Nombre usuario").font(.custom("Poppins-Regular", size: 28)).foregroundColor(Color("Color"))
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
                        PulsosUsuario(usuario: usuario).environmentObject(vm)
                    }.offset(y: 100)
                }.frame(maxWidth: .infinity)
            }
        }.ignoresSafeArea()
    }
}

struct PulsosUsuario: View {
    var usuario : Usuario
    @EnvironmentObject var vm : ViewModel
    var body: some View{
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading) {
                Text(NSLocalizedString("Sus pulsos", comment: "")).font(.custom("Poppins-Regular", size: 28)).fontWeight(.bold).foregroundColor(Color("Color"))
            }

            }
            if ( vm.pulsos.filter({$0.usuarioRelation?.nombre == usuario.nombre}).count > 0 ) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(vm.pulsos.filter({$0.usuarioRelation?.nombre == usuario.nombre})) { pulso in
                            FilaPulsoUsuario(pulso: pulso)
                        }
                    }
                }.frame(maxWidth: .infinity)
            } else {
                Text("Todavía no tiene pulsos").font(.custom("Poppins-Regular", size: 20)).fontWeight(.bold).foregroundColor(Color("Color"))

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
                Text(pulso.nombrePulso ?? "").foregroundColor(Color("Color")).font(.system(size: 18, weight: .regular, design: .rounded))
                Text(pulso.ubicacion ?? "").foregroundColor(Color("Color")).font(.system(size: 14, weight: .regular, design: .rounded))
                Text(pulso.usuarioRelation?.nombre  ?? "").font(.caption)
            }.onTapGesture {
                showPulsoView = true
            }.contextMenu {
                VStack {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Text(NSLocalizedString("form-homeview-compartir", comment: ""))
                        Image(systemName: "square.and.arrow.up").foregroundColor(Color("Color"))
                    }
                }
            }
        }.sheet(isPresented: $showingSheet) {
            ShareSheetUsuario(items: [pulso.nombrePulso ?? "", pulso.a03, pulso.a27])
            
        }.padding().frame(width: 150, height: 150)
            .background(Color.accentColor)
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
