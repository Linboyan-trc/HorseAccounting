import SwiftDate
import SwiftUI

// 用来显示一个条目的View
struct ExpenseView: View {
    @EnvironmentObject var RacoonSheetConfig: SheetConfigModel

    // MARK: - 基础数据

    /// 该View呈现的expense
    var expenseInfo: ExpenseInfo

    // MARK: - 修改相关

    /// 条目是否能编辑
    var isEditable: Bool = true

    /// 要修改的Expense的id
    var uuidOfExpenseToEdit: UUID?

    var body: some View {
        //let amount_dispaly = String(format: "%.1f", expenseInfo.amount)
        let amount_dispaly = amountString(amount: expenseInfo.amount)

        VStack(alignment: .leading) {
            HStack {
                
                // [focus] & [forWho]
                HStack {
                    if let focus = expenseInfo.focus {
                        SingleComponentView(text: focus)
                    }

                    if expenseInfo.forWho != [] {
                        MultilineTagsForDisplay(
                            tags: expenseInfo.forWho.sorted(),
                            color: defaultColorSet.capsule.person
                        )
                    }
                }
                
                // [event]
                if expenseInfo.event != "" {
                    Text(expenseInfo.event)
                        .bold()
                        .font(.title3)
                        .foregroundColor(.primary)
                } else {
                    Text("请记录你的花销")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.secondary)
                }

                // [story icon]
                if expenseInfo.story != nil {
                    Text(Image(systemName: "bookmark.fill"))
                        .foregroundColor(defaultColorSet.storyRibbon)
                }

                Spacer()

                // [amount]
                Text("-" + amount_dispaly)
                    .bold()
                    .font(.title3)
                    .foregroundColor(.black)
            }
        }
        // 点击单个Expense弹出Sheet对Expense进行修改
        // 修改的逻辑是这样的：有一个真实的在数据库中的值，将该值拷贝一份放入新创建的expenseInfo_inputting，这样打开Sheet就会显示修改前的值；这个值是一个临时的变量，在Sheet中修改不会直接影响到该变量；只有当最后点击`修改`按钮的时候才会对数据库中的真实值进行修改
        .onTapGesture {
            // 是修改模式才判断点击
            if isEditable {
                // 这里的感叹号是因为修改的话必须传入确切的UUID
                RacoonSheetConfig.showEditSheet(uuidOfExpenseToEdit: uuidOfExpenseToEdit!, expenseInfo: expenseInfo)
            }
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
