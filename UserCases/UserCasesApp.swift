//
//  UserCasesApp.swift
//  UserCases
//
//  Created by Ethan Kisiel on 6/28/22.
//

import SwiftUI

@main
struct UserCasesApp: App {
    
    @StateObject private var realmManager = RealmManager.shared
    
    var body: some Scene {
        WindowGroup {
            VStack
            {
                if let configuration = realmManager.configuration, let realm = realmManager.realm
                {
                    AddEntryView()
                        .environment(\.realmConfiguration, configuration)
                        .environment(\.realm, realm)
                }
            }.task
            {
                try? await realmManager.initialize()
            }
        }
    }
}
