//
//  Step.swift
//  UserCases
//
//  Created by Ethan Kisiel on 6/29/22.
//

import Foundation
import RealmSwift

class Step
{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted title: String
}
