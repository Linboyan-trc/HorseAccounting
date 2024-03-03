import CoreData
import SwiftDate
import SwiftUI

struct MonthExpensesView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest var expensesInMonth: FetchedResults<Expense>

    var selectedDate: Date
    static var dates: [Date] = [Date()]

    init(selectedDate: Date) {
        self.selectedDate = selectedDate
        // 打开app默认展示的月份为当月
        let monthStart = selectedDate.dateAt(.startOfMonth)
        let monthEnd = selectedDate.dateAt(.endOfMonth)
        Self.dates = Date.dates(from: monthStart, to: monthEnd)

        let request_expensesInMonth = Expense.request_expensesInMonth(selectedDate)
        _expensesInMonth = FetchRequest(fetchRequest: request_expensesInMonth)
    }

    var body: some View {
            List{
                if expensesInMonth.count == 0 {
                    VStack {
                        Spacer()
                        
                        Text("这个月没有记账呢")
                            .padding()
                        
                        Text("长按").font(.system(.title2)) +
                        Text("右下角加号") +
                        Text("语音输入")
                            .font(.system(.title2, design: .rounded))
                        
                        Text("点按").font(.system(.title2)) +
                        Text("右下角加号") +
                        Text("手动输入")
                            .font(.system(.title2, design: .rounded))
                        
                        Text("点按").font(.system(.title2)) +
                        Text("右上角按钮") +
                        Text("截图导入账单")
                            .font(.system(.title2, design: .rounded))
                        
                        Spacer()
                    }.padding()
                } else {
                    ForEach(MonthExpensesView.dates.reversed(), id: \.self) {
                        DayExpensesView(date: $0)
                    }
                }
            }
    }
}

struct MonthExpensesView_Previews: PreviewProvider {

    static var previews: some View {
        MonthExpensesView(selectedDate: Date())
            .environment(\.managedObjectContext, PreviewUse.shared.previewViewContext.container.viewContext)
    }

}
