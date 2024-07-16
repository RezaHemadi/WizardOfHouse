//
//  PersonSelectionRow.swift
//  WizardOfHouse
//
//  Created by Reza on 7/7/24.
//

import SwiftUI

struct PersonSelectionRow: View {
    let person: WTPerson
    let selected: Bool
    
    var body: some View {
        HStack {
            Text(person.name)
            Spacer()
            if selected {
                Image(systemName: "checkmark")
            }
        }
    }
}

#Preview {
    PersonSelectionRow(person: WTPerson.SamplePpl[0], selected: true)
}
