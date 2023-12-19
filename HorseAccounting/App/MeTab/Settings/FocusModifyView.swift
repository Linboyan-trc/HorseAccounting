import SwiftUI

struct FocusModifyView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(fetchRequest: Focus.request_allFocus)
    var allFocus

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("标签")
                    .font(.system(.headline))

                FocusField(hint: "添加新标签")
                    .padding([.vertical], 5) // 不和下面的挨太近
            }

            MultilineFocusViewForModify(color: defaultColorSet.capsule.focus)

            HStack{
                Spacer()
                Text("删除标签后无法恢复!")
                    .bold()
                    .font(.system(.title3))
                Spacer()
            }
            .padding()
            
            HStack{
                Spacer()
                Text("请在删除前确认")
                    .bold()
                    .font(.system(.title3))
                Spacer()
            }
            .padding()
        }
        .padding() // 别碰到屏幕边儿上
    }
}
