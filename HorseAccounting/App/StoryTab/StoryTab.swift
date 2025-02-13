import SwiftDate
import SwiftUI

struct StoryTab: View {
    @Environment(\.managedObjectContext) var context

    @FetchRequest(fetchRequest: Expense.request_allExpensesWithStory)
    var expensesWithStory

    static let emojiSize: CGFloat = 40

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ZStack {
                    defaultColorSet.tabBackground.ignoresSafeArea() // background color: 目的是把ZStack撑开 因为下面的VStack用了if else 所以SwiftUI不能直接读取它的大小
                    VStack {
                        if expensesWithStory.count != 0 {
                            ForEach(expensesWithStory) { expense in
                                // 换成一个单另的View之后 ForEach的更新就不work了

                                VStack(alignment: .leading) {
                                    HStack {
                                        let amountFormatted = String(format: "¥%.1f", expense.amount)
                                        
                                        Text("\(DisplayDate(expense.spentAt)) \(expense.event)")
                                            .bold()
                                            .foregroundColor(defaultColorSet.cardTitle)

                                        Spacer()
                                        
                                        Text(amountFormatted)
                                            .bold()
                                            .foregroundColor(Color(hex:0x093C89))
                                            .padding([.horizontal])
                                    }
                                    .padding([.top, .leading])

                                    // seperator
                                    Rectangle()
                                        .fill(defaultColorSet.tabBackground)
                                        .frame(height: 1)

                                    VStack(alignment: .leading) {
                                        // contentView
                                        let text = expense.story?.text ?? "为本次花销添加一段财记吧"

                                        Text(text)
                                            .font(.body)

                                        HStack(alignment: .center) {
                                            if let emoji = expense.story?.emoji {
                                                ZStack {
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .foregroundColor(defaultColorSet.emojiBackground)
                                                    Text(emoji)
                                                        .font(.title3)
                                                }
                                                .frame(width: Self.emojiSize, height: Self.emojiSize, alignment: .center)

                                                //Spacer()
                                            }

                                            if let rating = expense.story?.rating {
                                                RatingView(rating: Int(rating))
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    .padding([.horizontal, .bottom])
                                }
                                .frame(width: UIScreen.main.bounds.width - 20)
                                .background(Color.white.ignoresSafeArea())
                                .cornerRadius(10)
                                .clipped()
                            }
                            .padding(.horizontal, 10) // 让圆角矩形边框不靠边
                        }
                        else {
                            VStack(alignment: .center) {
                                Text("一笔财记还没有呢")
                                Text("给花销添加背后故事吧！").font(.system(.title2))
                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 20)
                            .background(Color.white)
                            .cornerRadius(10)
                            .clipped()
                        }
                    }
                    .padding(.vertical, 5) // 让上下两个stroy不靠边
                }
                .navigationTitle("财记")
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(defaultColorSet.tabBackground.ignoresSafeArea()) // background color:真正上色
        }
    }
}
