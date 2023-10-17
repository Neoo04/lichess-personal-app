//
//  lichess_personal_appApp.swift
//  lichess-personal-app
//
//  Created by generic dev on 10/17/23.
//

import SwiftUI

@main
struct lichess_personal_appApp: App {

    init() {
        _ = DependencyInitializer()
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack(root: {
                RootMainView()
            })
        }
    }
}
