//
//  AddEntryView.swift
//  UserCases
//
//  Created by Ethan Kisiel on 6/29/22.
//

import Neumorphic
import RealmSwift
import SwiftUI

struct AddEntryView: View
{
    @State private var title: String = ""
    @State private var priority: Priority = .medium
    
    @FocusState var isFocused: Bool
    init()
    {
        self.isFocused = false
    }
    
    @ObservedResults(UseCase.self) var useCases: Results<UseCase>
    
    var body: some View
    {
        NavigationView
        {
            VStack(alignment: .leading)
            {
                Text("Priority:")
                    .foregroundColor(.secondary)
                    .fontWeight(.bold)
                    .offset(x: 5)
                    .scaleEffect(1, anchor: .leading)
                
                Picker("Priority", selection: $priority)
                {
                    ForEach(Priority.allCases, id: \.self)
                    {
                        priority in
                        Text(priority.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(5)
                
                HStack(spacing: 5)
                {
                    TextInputField("Title", text: $title, isFocused: $isFocused).padding(5)
                    
                    if !title.isEmpty
                    {
                        Button(action: {
                            let useCase = UseCase()
                            useCase.title = title
                            useCase.priority = priority
                            
                            $useCases.append(useCase)
                            
                            title = ""
                            priority = .medium
                            isFocused = false
                        })
                        {
                            Text("Save")
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 10), padding: 15)
                        .padding(10)
                    }
                }
    
                UseCasesView().padding(5)
                Spacer()
                .navigationTitle("Add Use Case")
            }
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
