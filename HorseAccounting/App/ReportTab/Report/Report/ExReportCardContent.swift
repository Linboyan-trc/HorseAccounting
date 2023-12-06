import CoreData
import SwiftDate
import SwiftUI

struct ExReportCardContent: View {
    var expenseSum: Float
    var expenseCount: Int
    var maxExpense: Expense?

    var isMonth: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            if expenseSum == 0 {
                Text("还没有记账信息呢")
            } else {
                let expenseAvgInThisMonth = String(format: "%.1f", expenseSum / Float(Date().day))
                ReportItemView(
                    reportTitle: "总支出",
                    reportBody: "¥" + String(format:"%.1f",expenseSum),
                    reportTintColor: Color(hex:0x093C89),
                    reportNote: isMonth ? "相当于每天花 \(expenseAvgInThisMonth) 元" : nil
                )
                .padding([.bottom])

                ReportItemView(
                    reportTitle: "支出笔数",
                    reportBody: "\(expenseCount) 笔",
                    reportTintColor: Color(hex:0x0277B4),
                    reportNote: nil
                )
                .padding([.bottom])
                if let maxEx = maxExpense {
                    ReportItemView(
                        reportTitle: "最高支出",
                        reportBody: "\(maxEx.event)",
                        reportTintColor: Color(hex:0x24a0e0),
                        reportNote: "\(DisplayDate(maxEx.spentAt)), 在\(maxEx.event)上花了 \(maxEx.amount) 元"
                    )
                }
            }
        }
    }
}
