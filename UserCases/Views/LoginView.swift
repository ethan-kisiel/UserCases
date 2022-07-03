//
//  LoginView.swift
//  UserCases
//
//  Created by Ethan Kisiel on 7/3/22.
//

import RealmSwift
import SwiftUI

struct LoginView: View {
    
    @Environment(\.realm) var realm
    @ObservedResults(UserModel.self) var users: Results<UserModel>
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmation: String = ""
    var targetUser: UserModel
    {
        users.first {$0.username == username} ?? UserModel()
    }
    @State var signUp: Bool = false
    @State var userValidated: Bool = false
    
    @FocusState var isFocused: Bool
    init()
    {
        isFocused = false
    }
    var body: some View {
        NavigationView
        {
            VStack
            {
                TextInputField("Username", text: $username, isFocused: $isFocused)
                TextInputField("Password", text: $password, isFocused: $isFocused)
                if signUp
                {
                    TextInputField("Confirm Password", text: $confirmation, isFocused: $isFocused)
                }

                Button(action: {
                    
                    if !signUp
                    {
                        if !targetUser.username.isEmpty && password == targetUser.password
                        {
                            userValidated = true
                        }
                        else
                        {
                            signUp.toggle()
                        }
                    }
                    else
                    {
                        if !username.isEmpty && !password.isEmpty && !confirmation.isEmpty && confirmation == password
                        {
                            let newUser = UserModel()
                            
                            newUser.username = username
                            newUser.password = password
                            
                            $users.append(newUser)
                            
                            signUp.toggle()
                        }
                    }
                    isFocused = false
                })
                {
                    Text(signUp ? "Create Account" : "Sign In")
                }
                .softButtonStyle(RoundedRectangle(cornerRadius: 10), padding: 15)
                .padding(10)
                .fullScreenCover(isPresented: $userValidated)
                {
                    AddEntryView(targetUser)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
