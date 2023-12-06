//
//  HorseAccountingApp.swift
//  HorseAccounting
//
//  Created by 杨荣津 on 2023/12/6.
//

import SwiftUI

@main
struct HorseAccountingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
