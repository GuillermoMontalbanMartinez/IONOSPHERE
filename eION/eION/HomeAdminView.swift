//
//  HomeAdminView.swift
//  eION
//
//  Created by Marta Fernandez Garcia on 25/11/21.
//

import SwiftUI


// Avanzar con este tutorial: https://blckbirds.com/post/charts-in-swiftui-part-2-pie-chart/

struct PieSlice {
    var startDegree: Double
    var endDegree: Double
}

/* Los datos que vamos a necesitar deben tener una label y un value*/
struct ChartData {
    var label: String
    var value: Int
}

/* Debe haber tantos colores como datos tengamos en chartDataSet*/
let pieColors = [
    Color.init(hex: "#2f4b7c"),
    Color.init(hex: "#ffa600")
]

/* Los datos que se van a representar en el diagrama*/
var chartDataSet : [ChartData] = []

/* Un array de vistas de tipo PieSlice*/
var pieSlices: [PieSlice] {
    var slices = [PieSlice]()
    
    /* enumerated() devuelve el par (indice, dato), así podemos hacer el foreach e iterar sobre cada indice del array y obtener el dato correspondiente (data) */
    chartDataSet.enumerated().forEach {(index, data) in
        let value = normalizedValue(index: index, data: chartDataSet)
        if slices.isEmpty    {
            slices.append((.init(startDegree: 0, endDegree: value * 360)))
        } else {
            slices.append(.init(startDegree: slices.last!.endDegree,    endDegree: (value * 360 + slices.last!.endDegree)))
        }
    }
    return slices
}

func normalizedValue(index: Int, data: [ChartData]) -> Double {
    var total = 0.0
    data.forEach { data in
        total += Double(data.value)
    }
    
    return Double(data[index].value)/total
}


struct HomeAdminView: View {
    @State private var currentIndex = -1

    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Estadísticas")
                            .bold()
                            .font(.largeTitle)
                        ZStack {
                            ZStack  {
                                ForEach(0..<chartDataSet.count){ i in
                                    PieChartSlice(center: CGPoint(x: geometry.frame(in: .local).midX, y: (geometry.frame(in:  .local).minY) + 200), radius: geometry.frame(in: .local).width/2, startDegree: pieSlices[i].startDegree, endDegree: pieSlices[i].endDegree, accentColor: pieColors[i], separatorColor: Color.white).scaleEffect(currentIndex != -1 && currentIndex == i ? 1 : 0.9).opacity(currentIndex == i || currentIndex == -1 ? 1 : 0.5)
                                        .onTapGesture {
                                            
                                            withAnimation(.spring()) {
                                                if currentIndex == i {
                                                    currentIndex = -1
                                                } else {
                                                    currentIndex = i
                                                }
                                            }
                                        }
                                }
                            }
                            
                            VStack  {
                                if currentIndex != -1{
                                    Text("\(chartDataSet[currentIndex].value)")
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(.black)
                                        .padding(5)
                                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
                                    
                                    Text("\(chartDataSet[currentIndex].label)")
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(.black)
                                        .padding(5)
                                        .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.white).shadow(radius: 3))
                                }
                            }
                            .padding()
                        }
                        
                        VStack(alignment:   .leading)  {
                            ForEach(0..<chartDataSet.count)   {    i in
                                HStack {
                                    pieColors[i]
                                        .aspectRatio(contentMode: .fit)
                                        .padding(10).frame(width: 50, height: 50)
                                    Text(chartDataSet[i].label)
                                        .font(.caption)
                                        .bold()
                                }
                            }
                        }
                    }.frame(height: geometry.size.height)
                }
            }
            .padding().navigationTitle("Administrador")
        }.onAppear{
            let data = vm.getInstanciasClases()
            
            chartDataSet = [
                ChartData(label: "Good", value: data["Good"] ?? 10),
                ChartData(label: "Bad", value: data["Bad"]  ?? 11)
            ]
            
        }
    }
}

struct PieChartSlice: View {
    var center: CGPoint
    var radius: CGFloat
    var startDegree: Double
    var endDegree: Double
    var accentColor:  Color
    var separatorColor: Color
    
    var path: Path {
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startDegree), endAngle: Angle(degrees: endDegree), clockwise: false)
        path.addLine(to: center)
        path.closeSubpath()
        return path
    }
    
    var body: some View {
        path
            .fill(accentColor)
            .overlay(path.stroke(separatorColor, lineWidth: 10))
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}



/*struct HomeAdminView_Previews: PreviewProvider {
 static var previews: some View {
 HomeAdminView(mostrarInformación: true)
 }
 }*/

