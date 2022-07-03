//
//  UseCaseView.swift
//  UserCases
//
//  Created by Ethan Kisiel on 7/2/22.
//

import Neumorphic
import RealmSwift
import SwiftUI

struct UseCaseView: View
{
    @ObservedRealmObject var useCase: UseCase
    @State private var stepText: String = ""

    @FocusState var isFocused: Bool
    init(useCase: UseCase)
    {
        self.useCase = useCase
        isFocused = false
    }

    var body: some View
    {
        VStack
        {
            HStack(spacing: 5)
            {
                TextInputField("Enter Step", text: $stepText, isFocused: $isFocused).padding(5)

                if !stepText.isEmpty
                {
                    Button(action: {
                        let step = Step()
                        step.text = stepText
                        $useCase.steps.append(step)

                        // Clear the field
                        stepText = ""
                        isFocused = false
                    })
                    {
                        Text("Save")
                    }
                    .softButtonStyle(RoundedRectangle(cornerRadius: 10), padding: 15)
                    .padding(10)
                }
            }

            List
            {
                ForEach(useCase.steps.indices, id: \.self)
                {
                    index in
                    let step = useCase.steps[index]
                    HStack
                    {
                        Text("\(index + 1):")
                            .frame(width: 25, height: 25)
                            .foregroundColor(.secondary)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                        Text(step.text)
                    }
                }.onDelete(perform: $useCase.steps.remove)
                .listStyle(.plain)
            }

            .navigationTitle(useCase.title)

        }.padding()
    }
}

struct UseCaseView_Previews: PreviewProvider
{
    static var previews: some View
    {
        UseCaseView(useCase: UseCase())
    }
}
