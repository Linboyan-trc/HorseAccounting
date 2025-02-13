//
//  PieChartView.swift
//
//  https://betterprogramming.pub/build-pie-charts-in-swiftui-822651fbf3f2
//
//  Created by Nazar Ilamanov on 4/23/21.
//

import SwiftUI

public struct PieChartView: View {
    public let values: [Double]
    public let names: [String]
    public let formatter: (Double) -> String

    public var colors: [Color]
    public var backgroundColor: Color

    public var widthFraction: CGFloat
    public var innerRadiusFraction: CGFloat

    @State private var activeIndex: Int = -1

    var slices: [PieSliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [PieSliceData] = []

        for (i, value) in values.enumerated() {
            let degrees: Double = value * 360 / sum
            if((value * 100 / sum)<4.0){
                tempSlices.append(
                    PieSliceData(startAngle: Angle(degrees: endDeg),
                                 endAngle: Angle(degrees: endDeg + degrees),
                                 text: "",
                                 color: colors[i]))
                endDeg += degrees
            }else{
                tempSlices.append(
                    PieSliceData(startAngle: Angle(degrees: endDeg),
                                 endAngle: Angle(degrees: endDeg + degrees),
                                 text: String(format: "%.0f%%", value * 100 / sum),
                                 color: colors[i]))
                endDeg += degrees
            }
        }
        return tempSlices
    }

    public init(
        values: [Double],
        names: [String],
        formatter: @escaping (Double) -> String,
        colors: [Color] = ColorSet.shared.colors,
        backgroundColor: Color = Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0),
        widthFraction: CGFloat = 0.75,
        innerRadiusFraction: CGFloat = 0.60
        ) {
        self.values = values
        self.names = names
        self.formatter = formatter

        self.colors = colors
        self.backgroundColor = backgroundColor
        self.widthFraction = widthFraction
        self.innerRadiusFraction = innerRadiusFraction
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ForEach(0 ..< self.values.count, id: \.self) { i in
                        if !values[i].isZero {
                            PieSlice(pieSliceData: self.slices[i])
                                .scaleEffect(self.activeIndex == i ? 1.08 : 1)
                                .animation(Animation.spring())
                        }
                    }
                    .frame(width: widthFraction * geometry.size.width, height: widthFraction * geometry.size.width)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let radius = 0.5 * widthFraction * geometry.size.width
                                let diff = CGPoint(x: value.location.x - radius, y: radius - value.location.y)
                                let dist = pow(pow(diff.x, 2.0) + pow(diff.y, 2.0), 0.5)
                                if dist > radius || dist < radius * innerRadiusFraction {
                                    self.activeIndex = -1
                                    return
                                }
                                var radians = Double(atan2(diff.x, diff.y))
                                if radians < 0 {
                                    radians = 2 * Double.pi + radians
                                }

                                for (i, slice) in slices.enumerated() {
                                    if radians < slice.endAngle.radians {
                                        self.activeIndex = i
                                        break
                                    }
                                }
                            }
                            .onEnded { _ in
                                self.activeIndex = -1
                            }
                    )
                    
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(
                            width: widthFraction * geometry.size.width * innerRadiusFraction,
                            height: widthFraction * geometry.size.width * innerRadiusFraction)

                    VStack {
                        Text(self.activeIndex == -1 ? "总计" : names[self.activeIndex])
                            .font(.title)
                            .foregroundColor(Color.gray)
                        Text(self.formatter(self.activeIndex == -1 ? values.reduce(0, +) : values[self.activeIndex]))
                            .font(.system(.title, design: .rounded))
                    }
                }
                PieChartRows(
                    colors: self.colors,
                    names: self.names,
                    values: self.values.map { self.formatter($0) },
                    percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) })
            }
            .background(self.backgroundColor)
            .foregroundColor(Color.black)
        }
    }
}

struct PieChartRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]

    var body: some View {
        VStack {
            ForEach(0 ..< self.values.count, id: \.self) { i in
                if values[i] != "0.0" {
                    HStack {
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 5.0)
                            .fill(self.colors[i])
                            .frame(width: 20, height: 20)
                        
                        Text(self.names[i])
                            .foregroundColor(Color.black)
                            .font(.system(.title2))
                        Text(self.values[i])
                            .foregroundColor(Color.gray)
                            .font(.system(.title3, design: .rounded))
                        Text(self.percents[i])
                            .foregroundColor(Color.black)
                            .font(.system(.title2, design: .rounded))
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

//struct PieChartView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        PieChartView(
//                values: PreviewUse.shared.tempExpenseSumListPreview,
//                names: PreviewUse.shared.tempFocusNameListPreview,
//                formatter: { value in String(format: "%.1f", value) },
//                backgroundColor: defaultColorSet.tabBackground
//            )
//            .environment(\.managedObjectContext, PreviewUse.shared.previewViewContext.container.viewContext)
//    }
//
//}

