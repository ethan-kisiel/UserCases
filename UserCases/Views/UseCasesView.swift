//
//  UseCasesView.swift
//  UserCases
//
//  Created by Ethan Kisiel on 7/1/22.
//

import RealmSwift
import SwiftUI
enum Sections: String, CaseIterable
{
    case pending = "Pending"
    case completed = "Completed"
}

struct UseCasesView: View {
    
    @Environment(\.realm) var realm
    @ObservedResults(UseCase.self) var useCases: Results<UseCase>
    
    var pendingCases: [UseCase]
    {
        useCases.filter { $0.isCompleted == false }
    }
    var completedCases: [UseCase]
    {
        useCases.filter { $0.isCompleted == true }
    }
    
    var body: some View {
        List
        {
            ForEach(Sections.allCases, id: \.self)
            {
                section in
                Section
                {
                    let filteredCases = section == .pending ? pendingCases : completedCases
                    
                    if filteredCases.isEmpty
                    {
                        switch section
                        {
                        case .pending:
                            Text("No Pending Use Cases")
                        case .completed:
                            Text("No Completed Use Cases")
                        }
                    }
                    
                    ForEach(filteredCases, id: \._id)
                    {
                        useCase in
                        UseCaseView(useCase: useCase)
                    }.onDelete
                    {
                        indexSet in
                        indexSet.forEach
                        {
                            index in
                            let useCase = filteredCases[index]
                            
                            guard let caseToDelete = realm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
                            else
                            {
                                return
                            }
                            
                            $useCases.remove(caseToDelete)
                        }
                    }
                } header:{
                    Text(section.rawValue)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct UseCasesView_Previews: PreviewProvider {
    static var previews: some View {
        UseCasesView()
    }
}
