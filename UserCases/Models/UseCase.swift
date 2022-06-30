//
//  UseCase.swift
//  UserCases
//
//  Created by Ethan Kisiel on 6/29/22.
//

import Foundation
import RealmSwift
enum Priority: String, CaseIterable, PersistableEnum
{
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

class UseCase: Object, Identifiable
{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String = "" // replace with Constants.EMPTY_STRING?
    @Persisted var isCompleted: Bool = false
    @Persisted var priority: Priority = .medium
    
}
