import CoreData
import SwiftDate
import SwiftUI

struct BookTab: View {
    @EnvironmentObject var RacoonSheetConfig: SheetConfigModel

    @Environment(\.managedObjectContext) private var context

    @State private var selectedDate = Date()

    private let onSideMenuOpen: () -> Void
    private let onSideMenuClose: () -> Void
    private let isSideMenuOpen: Bool

    // --- 31 ---

    init(thisYear _: Int = Date().year,
         thisMonth _: Int = Date().month,
         onSideMenuOpen: @escaping () -> Void,
         onSideMenuClose: @escaping () -> Void,
         isSideMenuOpen: Bool)
    {
        // 打开app默认展示的月份为当月
        self.onSideMenuOpen = onSideMenuOpen
        self.onSideMenuClose = onSideMenuClose
        self.isSideMenuOpen = isSideMenuOpen
    }

    var body: some View {
        NavigationView {
            MonthExpensesView(selectedDate: selectedDate)
            .blur(radius: RacoonSheetConfig.shared.blurRadius)
        
            .background(defaultColorSet.tabBackground.ignoresSafeArea())
        
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("支出")
        
            .navigationBarItems(
                // 日期选择
                leading:
                DatePicker(
                    "",
                    selection: $selectedDate,
                    in: ...Date(),
                    displayedComponents: .date
                ),
                
                // 截图导入按钮
                trailing:
                Button{
                    RacoonSheetConfig.shared.showingScreenshotImportSheet.toggle()
                } label: {
                    HStack{
                        Image(systemName: "photo")
                            .foregroundColor(Color(hex:0x093C89))
                        Spacer()
                    }
                    .frame(width: 50)
                }
            )
            .sheet(
                // 控制截图导入页面显示
                isPresented: $RacoonSheetConfig.shared.showingScreenshotImportSheet,
                onDismiss: didDismissScreenshotImportSheet
            ) {
                ScreenshotImportSheet()
                    .environmentObject(RacoonSheetConfig)
                    .environment(\.managedObjectContext, context)
            }
        }
    }

    private func didDismissScreenshotImportSheet() {}
}

