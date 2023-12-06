//
//  LineChartTest.swift
//  ScrollViewTest
//
//  Created by 杨荣津 on 2023/12/6.
//

import SwiftUI

struct LineChartView: View {
    
    public let values: [Double]
    public let names: [String]
    public let formatter: (Double) -> String
    public var colors:[Color]
    var maxExpense:Double{
        values.max() ?? 0
    }
    var avgExpense:Double{
        if values.count == 0 {
            return 0.0
        } else {
            return values.reduce(0, +) / Double(validCount)
        }
    }
    var minExpense:Double = 0.0
    var yAxis:Double{
        maxExpense - minExpense
    }
    var validCount:Int{
        var cnt = 0
        for i in values{
            if !i.isZero{
                cnt = cnt + 1
            }
        }
        return cnt
    }
    
    init(
        values:[Double],
        names:[String],
        formatter: @escaping(Double) -> String,
        colors: [Color] = ColorSet.shared.colors
    ){
        self.values = values
        self.names = names
        self.formatter = formatter
        self.colors = colors
    }
    
    var body: some View {
        VStack{
            lineChartView
                .frame(width: 300,height: 150)
                .background(chartBackground)
                .overlay(chartYAxis)
            PieChartRows(
                colors: self.colors,
                names: self.names,
                values: self.values.map { self.formatter($0) },
                percents: self.values.map { String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +)) })
        }
    }
}

extension LineChartView {
    
    private var lineChartView:some View{
        GeometryReader{ geometry in
            Path{ path in

                for index in values.indices{
                    if !values[index].isZero{
                        //数据点的坐标
                        let xPosition = geometry.size.width / CGFloat(validCount) * CGFloat(index + 1)
                        let yPosition = (1 - CGFloat(values[index]-minExpense) / yAxis) * geometry.size.height

                        if path.isEmpty {
                            path.move(to:CGPoint(x: xPosition, y: yPosition))
                        } else {
                            path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                        }
                    }
                }

            }
            .stroke(Color(hex:0x093C89), style: StrokeStyle(lineWidth:2,lineCap: .round,lineJoin: .round))

            ForEach(values.indices,id:\.self){ index in
                if !values[index].isZero {
                    let xPosition = geometry.size.width / CGFloat(validCount) * CGFloat(index + 1)
                    let yPosition = (1 - CGFloat(values[index]-minExpense) / yAxis) * geometry.size.height
                    Circle()
                        .strokeBorder(Color(hex:0x093C89), lineWidth: 2)
                        .background(Circle().fill(Color.white))
                        .frame(width:8)
                        .position(x:xPosition,y:yPosition)
                }
            }
        }
    }
    
    private var chartBackground:some View{
        GeometryReader{ geometry in
            VStack{
                Divider()
                Spacer()
                Divider()
                Spacer().frame(height: CGFloat(avgExpense-minExpense) / CGFloat(yAxis) * geometry.size.height)
                Divider()
            }
        }
    }
    
    private var chartYAxis:some View{
        GeometryReader{ geometry in
            VStack{
                HStack{
                    Spacer()
                    Text(formatter(maxExpense))
                }
                Spacer()
                HStack{
                    Spacer()
                    Text(formatter(avgExpense))
                }
                Spacer().frame(height:  CGFloat(avgExpense-minExpense) / CGFloat(yAxis) * geometry.size.height)
            }
        }
    }
    
}
