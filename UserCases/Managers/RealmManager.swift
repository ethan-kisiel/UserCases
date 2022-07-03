//
//  RealmManager.swift
//  UserCases
//
//  Created by Ethan Kisiel on 6/29/22.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject
{
    let app: App
    
    @Published var realm: Realm?
    static let shared = RealmManager()
    @Published var user: User?
    @Published var configuration: Realm.Configuration?
        
    private init()
    {
        self.app = App(id: "application-0-biyir")
    }
    
    @MainActor
    func initialize() async throws
    {
        // authentications
        user = try await app.login(credentials: Credentials.anonymous)
        
        self.configuration = user?.flexibleSyncConfiguration(initialSubscriptions: {subs in
            if let _ = subs.first(named: "all-use-cases"), let _ = subs.first(named: "all-steps")
            {
                return
            }
            else
            {
                subs.append(QuerySubscription<UseCase>(name: "all-use-cases"))
                subs.append(QuerySubscription<Step>(name: "all-steps"))
            }
        }, rerunOnOpen: true)
        
        realm = try! await Realm(configuration: configuration!, downloadBeforeOpen: .always)
    }
}
