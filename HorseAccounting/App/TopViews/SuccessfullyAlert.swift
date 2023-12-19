// SuccessfullyAlert.swift

import Foundation
import SwiftUI

struct SuccessfullyAlert: View {
    @EnvironmentObject var RacoonSheetConfig: SheetConfigModel

    @Binding var showAddSuccessfullyAlert: Bool

    var body: some View {
        VStack {
            ZStack{
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .foregroundColor(Color(hex:0x093C89,alpha: 0.5))
                    .cornerRadius(12)
        
                VStack{
                    Text(RacoonSheetConfig.shared.isEditMode ? "已更新！" : "已添加！")
                        .foregroundColor(.black)
                        .font(.system(.title))
                        .padding([.horizontal, .top])
                    
                    ExpenseView(expenseInfo: RacoonSheetConfig.shared.expense_inputting)
                        .padding()
                }
                .frame(width: UIScreen.main.bounds.width - 104,height: 146)
                .background(defaultColorSet.tabBackground)
                .cornerRadius(10)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 100,height: 150)
        .background(defaultColorSet.alertBackground)
        .cornerRadius(12)
        .clipped()
        .padding() // 和右边离远一点
        .onAppear {
            // 过一段时间自行消失
            let appearingTimeInterval: TimeInterval = 4 // seconds
            Timer.scheduledTimer(withTimeInterval: appearingTimeInterval, repeats: false) { _ in
                withAnimation(.easeInOut) {
                    showAddSuccessfullyAlert = false
                }
            }
        }
    }
}
