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
                
                List{
                    NavigationLink(destination: SideMenu_Settings())
                    {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                            .font(.system(size:20))
                            
                        
                        Text("修改标签")
                            .foregroundColor(.black)
                            .bold()
                        
                        Spacer()
                    }
                    
                }
                .padding([.horizontal])
                .frame(maxWidth: .infinity, maxHeight:500)
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .background(defaultColorSet.tabBackground.ignoresSafeArea())
        }
    }
}
