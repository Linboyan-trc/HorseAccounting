//
//  HorseAccountingApp.swift
//  HorseAccounting
//
//  Created by 杨荣津 on 2023/12/6.
//

// App Entrance

import AVFoundation
import CoreData
import SwiftUI
import XCLog

@main
struct HorseAccountingApp: App {
    @StateObject var RacoonSheetConfig = SheetConfigModel()

    let persistenceController = PersistenceController.shared

    init() {
        #if DEV
            XCLog(.trace, "RacoonAccountBook Dev 开始运行")
        #else
            XCLog(.trace, "RacoonAccountBook 开始运行")
        #endif

        #if DEV
            // 测试的时候 删除所有的Focus 再进行添加
            Focus.deleteAll(context: persistenceController.container.viewContext)
            let focusList: [String] = ["食堂","外卖","下馆子","零食","奶茶","水果","衣服裤袜","护肤品","头发相关","生活用品","电子产品","水电费","洗衣服","医疗","运动","学费","书本费","资料费","文具纸张","其他学习开支","飞机高铁","公交地铁","共享单车","聚餐团建","KTV","展览","旅游景点","看电影","网络会员","手机话费"] // 初始化的focusList 只在用户第一次打开才会是这样
            for focus in focusList {
                Focus.focus(name: focus, context: persistenceController.container.viewContext)
            }
        #else
            // 实际使用：如果是第一次打开app 为用户添加一组默认的focus
            // QUESTION: 会不会出现有人卸载之后重新安装的情况啊 UserDefaults应该不是默认删除的
            if UserDefaults.isFirstLaunch() {
                // 如果focusList为空 为用户添加一组默认的focus
                if Focus.focusAmount(context: persistenceController.container.viewContext) == 0 {
                    let focusList: [String] = ["食堂","外卖","下馆子","零食","奶茶","水果","衣服裤袜","护肤品","头发相关","生活用品","电子产品","水电费","洗衣服","医疗","运动","学费","书本费","资料费","文具纸张","其他学习开支","飞机高铁","公交地铁","共享单车","聚餐团建","KTV","展览","旅游景点","看电影","网络会员","手机话费"] // 初始化的focusList 只在用户第一次打开才会是这样
                    for focus in focusList {
                        Focus.focus(name: focus, context: persistenceController.container.viewContext)
                    }
                }
            }
        #endif

        #if DEV
            // 每次重新运行App的时候，用TestData对数据库进行刷新；确保每次打开数据与TestData中的一致
            if let allExpenses = try? persistenceController.container.viewContext.fetch(Expense.request_allExpenses) {
                for expense in allExpenses {
                    persistenceController.container.viewContext.delete(expense)
                }
                for expenseInfo in GetTestExpenseInfos() {
                    Expense.create(expenseInfo: expenseInfo, context: persistenceController.container.viewContext)
                }

                let nowAllExpenses = try? persistenceController.container.viewContext.fetch(Expense.request_allExpenses)

                XCLog(.info, "删除并重新插入了测试数据共\(GetTestExpenseInfos().count)条, 现在数据库中有\(nowAllExpenses?.count ?? -1)条Expense")
            } else {
                XCLog(.error, "无法获取数据库数据")
            }

        #endif
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(RacoonSheetConfig)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

