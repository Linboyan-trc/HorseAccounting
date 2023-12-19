// Settings.swift

import SwiftUI

struct SideMenu_Settings: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                FocusModifyView()
            }
        }
        .navigationTitle("标签")
        .navigationBarTitleDisplayMode(.inline)
    }
}
