//
//  UseCasesView.swift
//  UserCases
//
//  Created by Ethan Kisiel on 7/1/22.
//

import RealmSwift
import SwiftUI

struct UseCasesView: View {
    @ObservedResults(UseCase.self) var useCases: Results<UseCase>
    var body: some View {
        ForEach(useCases)
        {
            useCase in
            
            Text(useCase.title)
        }
    }
}

struct UseCasesView_Previews: PreviewProvider {
    static var previews: some View {
        UseCasesView()
    }
}
