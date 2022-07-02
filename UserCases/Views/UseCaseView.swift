//
//  UseCaseView.swift
//  UserCases
//
//  Created by Ethan Kisiel on 7/1/22.
//

import SwiftUI

enum Squares: String
{
    case pending = "square"
    case completed = "square.inset.filled"
}

struct UseCaseView: View {

    let useCase: UseCase
    @Environment(\.realm) var realm
    
    private func priorityBackground(_ priority: Priority) -> Color
    {
        switch priority
        {
            case .low:
                return .green
            case .medium:
                return .orange
            case .high:
                return .red
            default:
                return .blue
        }
    }
    
    
    var body: some View {
        HStack
        {
            let iconName = useCase.isCompleted ? Squares.completed.rawValue : Squares.pending.rawValue
            
            Image(systemName: iconName)
                .onTapGesture
                {
                    let caseToUpdate = realm.object(ofType: UseCase.self, forPrimaryKey: useCase._id)
                    try? realm.write
                    {
                        caseToUpdate?.isCompleted.toggle()
                    }
                }
            Text(useCase.title)
            Spacer()
            Text(useCase.priority.rawValue)
                .padding(5)
                .frame(width: 75)
                .background(priorityBackground(useCase.priority))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
}

struct UseCaseView_Previews: PreviewProvider {
    static var previews: some View {
        UseCaseView(useCase: UseCase())
    }
}
