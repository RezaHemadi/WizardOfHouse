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
                .foregroundStyle(.white)
            Spacer()
            if selected {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color(hex: "F3C677"))
            }
        }
    }
}

#Preview {
    PersonSelectionRow(person: WTPerson.SamplePpl[0], selected: true)
}
