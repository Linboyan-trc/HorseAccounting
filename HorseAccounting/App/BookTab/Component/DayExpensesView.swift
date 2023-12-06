import SwiftDate
import SwiftUI

struct DayExpensesView: View {
    @Environment(\.managedObjectContext) private var context

    var date: Date
    @FetchRequest var dayExpenses: FetchedResults<Expense>
    
    private var totalDayAmount:Float{
        return dayExpenses.reduce(0.0, { $0 + $1.amount })
    }

    init(date: Date) {
        self.date = date
        let request = Expense.request_expensesInDay(day: date)
        _dayExpenses = FetchRequest(fetchRequest: request)
    }

    var body: some View {
        let date_display: String = DisplayDate(date)

        if dayExpenses.count != 0 {
            Section(header:
                HStack{
                    Text(date_display)
                        .foregroundColor(defaultColorSet.bookTabTitle)
                    Spacer()
                    Text("支出: " + amountString(amount: totalDayAmount))
                }
                .font(.headline)
            ){
                ForEach(dayExpenses) { expense in
                    ExpenseView(expenseInfo: expense.expenseInfo,
                                uuidOfExpenseToEdit: expense.uuid)
                    .padding([.top], 3) // 不同 ExpenseView 之间上下
                    .frame(height: 37)
                }
            }
        } else {
            EmptyView() // 不显示没有items的天
        }
    }
    
    private func amountString(amount:Float)->String{
        var formattedString: String

        if amount == Float(Int(amount)) {
            // 整数，不显示小数
            formattedString = String(format: "%.0f", amount)
        } else if amount * 10 == Float(Int(amount * 10)) {
            // 一位小数
            formattedString = String(format: "%.1f", amount)
        } else {
            // 两位小数
            formattedString = String(format: "%.2f", amount)
        }

        return formattedString
    }
    
}
