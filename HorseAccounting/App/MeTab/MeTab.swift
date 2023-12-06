// MeTab.swift

import SwiftUI

struct MeTab: View {
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Spacer().frame(width: 20)
                    Image("image7") // 替换为用户头像的图像
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    Spacer().frame(width: 20)
                    Text("TorynCurtis") // 替换为用户的姓名
                        .font(.title)
                        .padding()
                    Spacer()
                }
                .padding(.horizontal)
                
                // AR小人
                ARPersonView() // 替换为显示AR小人的视图
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .listStyle(.insetGrouped)

            .navigationBarTitle("", displayMode: .inline) // 隐藏导航栏标题
            .navigationBarItems(trailing:
                NavigationLink(destination: SideMenu_Settings()) {
                    Image(systemName: "gearshape")
                    .foregroundColor(.black)
                    .font(.system(size:20))
                    .padding(.horizontal)
                }
            )
        }
    }
}

struct ARPersonView: View {
    var body: some View {
        Text("广告位") // 替换为AR小人的内容
    }
}
