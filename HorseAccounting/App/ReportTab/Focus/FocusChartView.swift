// FocusChartView.swift

import CoreData
import SwiftUI

struct FocusChartView: View {
    // 环境变量
    @Environment(\.managedObjectContext) var context

    // 获取得到所有开销 数值 名字
    @State var sumList: [Double] = []
    @State var focusNameList: [String] = []
    
    // 折线图和圆环图选择
    @Binding var selectedFocusMode:ReportTab.FocusModeChoice

    var body: some View {
        VStack {
            if (sumList.reduce(0.0) { $0 + $1 }) == 0 {
                // 这里要统计的是所有有Focus的支出的钱数 不为0就可以绘图
                Text("使用「关注」来管理财记 重点分明")
                Text("添加一笔含有「关注」的花销吧！")
            } else {
                switch selectedFocusMode{
                    case .Pie:
                        PieChartView(
                            values: sumList,
                            names: focusNameList,
                            formatter: { value in String(format: "%.1f", value) },
                            backgroundColor: defaultColorSet.tabBackground
                        )
                    case .Line:
                    LineChartView(
                        values: sumList,
                        names: focusNameList,
                        formatter: { value in String(format: "%.1f", value) }
                    ).environment(\.managedObjectContext, context)
                }
            }
        }
        .onAppear {
            var tempFocusNameList: [String] = []
            var tempExpenseSumList: [Double] = []

            let focusExpenseSumDict = Focus.FocusExpenseSumDictionary(context: context)
            for (focusName, expenseSum) in focusExpenseSumDict.sorted(by: {
                $0.value > $1.value // 这里排序确保最高金额的颜色总是默认的第一个颜色
            }
            ) {
                tempFocusNameList.append(focusName)
                tempExpenseSumList.append(Double(expenseSum))
            }
            sumList = tempExpenseSumList
            focusNameList = tempFocusNameList
        }
    }
}

//struct FocusChartView_Previews: PreviewProvider {
//
//    @State static var selectedFocusMode = ReportTab.FocusModeChoice.Pie
//    
//    static var previews: some View {
//        FocusChartView(selectedFocusMode: $selectedFocusMode)
//            .environment(\.managedObjectContext, PreviewUse.shared.previewViewContext.container.viewContext)
//    }
//
//}
