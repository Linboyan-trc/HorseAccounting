import SwiftUI

struct NewExtraExpenseInfoButtons: View {
    @Binding var expenseInfo_inputting: ExpenseInfo

    @Binding var showingStory: Bool
    @Binding var showingForWho: Bool

    var body: some View {
        HStack {
            SingleExtraExpenseInfoView(expenseInfo_inputting: $expenseInfo_inputting,
                                       extraExpenseInfoName: "财记",
                                       showing: $showingStory,
                                       color: Color(hex:0x426DAD))
                .padding([.horizontal])
            Spacer()
        }
    }
}
