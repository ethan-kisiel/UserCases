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
    
    @ObservedResults(UseCase.self) var useCases: Results<UseCase>
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
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
                    TextInputField("Title", text: $title).padding(5)
                    
                    
                    if !title.isEmpty
                        {
                        Button(action: {
                            let useCase = UseCase()
                            useCase.title = title
                            useCase.priority = priority
                            
                            $useCases.append(useCase)
                            
                            title = ""
                            priority = .medium
                        })
                        {
                            Text("Save")
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 20), padding: 15)
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
