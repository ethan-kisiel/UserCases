//
//  User.swift
//  UserCases
//
//  Created by Ethan Kisiel on 7/3/22.
//

import Foundation
import RealmSwift

class UserModel: Object, Identifiable
{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var username: String = ""
    @Persisted var password: String = ""
    @Persisted var friendCode: String = ""
    @Persisted var useCases: List<UseCase> = List<UseCase>()
    @Persisted var friends: List<UserModel> = List<UserModel>()
}
