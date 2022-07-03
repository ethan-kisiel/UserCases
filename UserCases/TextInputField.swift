//
//  TextInputField.swift
//  HockeyInfoCoreData
//
//  Created by Larry Burris on 6/20/22.
//
import SwiftUI

//  Moves the text field placeholder value above the text field with animation
//  Usage: TextInputField(title: "First Name", text: $firstName)

struct TextInputField: View
{
    @Binding var text: String
    var isFocused: FocusState<Bool>.Binding

    var title: String

    init(_ title: String, text: Binding<String>, isFocused: FocusState<Bool>.Binding)
    {
        self.title = title
        _text = text
        self.isFocused = isFocused
    }

    var body: some View
    {
        withAnimation(.default)
        {
            ZStack(alignment: .leading)
            {
                Text(title + ":")
                    .foregroundColor(text.isEmpty ? .secondary : .secondary)
                    .fontWeight(.bold)
                    .offset(x: text.isEmpty ? 0 : 5, y: text.isEmpty ? 0 : -30)
                    .scaleEffect(text.isEmpty ? 1 : 1, anchor: .leading)

                TextField(title, text: $text)
                    .textFieldStyle(.roundedBorder)
                    .focused(self.isFocused)
            }
            .padding(.top, 15)
        }
    }
}
