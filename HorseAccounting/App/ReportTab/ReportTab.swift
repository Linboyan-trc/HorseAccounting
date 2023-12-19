import SwiftDate
import SwiftUI

struct ReportTab: View {
    @Environment(\.managedObjectContext) var context

    // 图标 简报 二选一
    @State private var selectedSegment: SegmentChoice = .focus
    enum SegmentChoice {
        case focus
        case report
    }
    
    // 每个页面的模式切换
    @State private var selectedFocusMode: FocusModeChoice = .Pie
    public enum FocusModeChoice{
        case Pie
        case Line
    }
    @State private var selectedReportMode:ReportModeChoice = .Expense
    enum ReportModeChoice{
        case Expense
        case Record
    }
    
    // 页面切换按钮
    private var navBarTrailingButton: some View {
        if selectedSegment == .focus {
            return AnyView(
                Button{
                    if selectedFocusMode == .Pie{
                        selectedFocusMode = .Line
                    } else {
                        selectedFocusMode = .Pie
                    }
                }label: {
                    if selectedFocusMode == .Pie{
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                    } else {
                        Image(systemName: "chart.pie")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                    }
                }
            )
        } else {
            return AnyView(
                Button{
                    if selectedReportMode == .Expense{
                        selectedReportMode = .Record
                    } else {
                        selectedReportMode = .Expense
                    }
                }label: {
                    if selectedReportMode == .Expense{
                        Image(systemName: "newspaper")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                    } else {
                        Image(systemName: "newspaper.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                    }
                }
            )
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Picker(selection: $selectedSegment, label: Text("页面")) {
                        Text("关注").tag(SegmentChoice.focus)
                        Text("简报").tag(SegmentChoice.report)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.top])
                    Spacer()
                }

                ScrollView {
                    VStack {
                        switch selectedSegment {
                        case .focus:
                            FocusChartView(selectedFocusMode: $selectedFocusMode)
                        case .report:
                            switch selectedReportMode{
                                case .Expense:  BriefReportView()
                                case .Record:   StoryReportView()
                            }
                        }
                    }
                    .environment(\.managedObjectContext, context)
                    .padding(.all, 10.0)
                }
                .padding(.bottom, 10.0)
            }
            .background(defaultColorSet.tabBackground.ignoresSafeArea())
            .navigationTitle("统计")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:navBarTrailingButton)
        }
        .edgesIgnoringSafeArea(.top)
    }

}

struct ReportTab_Previews: PreviewProvider {

    static var previews: some View {
        ReportTab()
            .environment(\.managedObjectContext, PreviewUse.shared.previewViewContext.container.viewContext)
    }

}
