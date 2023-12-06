import SwiftUI

struct SingleComponentView: View {
    var text: String

    var body: some View {
        switch text{
        case "食堂":
            Image("AAA_Canteen" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
        case "外卖" :
            Image("AAB_Takeout" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
        case "下馆子" :
            Image("AAC_Goout" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "零食" :
            Image("ABA_Snack" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "奶茶" :
            Image("ABB_Drink" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "水果" :
            Image("ABC_Fruit" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "衣服裤袜" :
            Image("BA_Clothes" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "护肤品" :
            Image("BB_Skin" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "头发相关" :
            Image("BC_Hair" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "生活用品" :
            Image("BD_LifeOthers" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "电子产品" :
            Image("BE_Electronics" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "水电费" :
            Image("CAA_WaterPower" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "洗衣服" :
            Image("CAB_WashingMachine" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "医疗" :
            Image("CB_Medical" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "运动" :
            Image("CC_Sports" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "学费" :
            Image("DA_fee" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "书本费" :
            Image("DB_Book" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "资料费" :
            Image("DC_Documents" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "文具纸张" :
            Image("DD_Ruler" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "其他学习开支" :
            Image("DE_StudyOthers" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "飞机高铁" :
            Image("EA_Plane" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "公交地铁" :
            Image("EB_PublicTrans" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "共享单车" :
            Image("EC_Bike" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "聚餐团建" :
            Image("FA_PartyDinner" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "KTV" :
            Image("GA_KTV" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "展览" :
            Image("GC_Exbhits" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "旅游景点" :
            Image("GD_Landscape" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "看电影" :
            Image("GE_Movie" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "网络会员" :
            Image("HA_VIP" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
         case "手机话费" :
            Image("HB_PhoneCharge" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
        default:
            Image("I" + "_01")
            .resizable()
            .scaledToFit()
            .frame(width: 35, height: 35)
        }
    }
}
