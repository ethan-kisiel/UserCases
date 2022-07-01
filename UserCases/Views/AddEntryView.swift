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
                TextInputField("Title", text: $title)
                
                Picker("Priority", selection: $priority)
                {
                    ForEach(Priority.allCases, id: \.self)
                    {
                        priority in
                        Text(priority.rawValue)
                    }
                }.pickerStyle(.segmented)
                
                if !title.isEmpty
                {
                    Button(action: {
                        let useCase = UseCase()
                        useCase.title = title
                        useCase.priority = priority
                        
                        $useCases.append(useCase)
                        
                        title = ""
                    })
                    {
                        Text("Save")
                    }
                    .softButtonStyle(RoundedRectangle(cornerRadius: 20), padding: 15)
                }
            }
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
    }
}
