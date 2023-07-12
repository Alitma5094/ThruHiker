//
//  JourneysCreate.swift
//  ThruHiker
//
//  Created by Drew Litman on 7/7/23.
//

import Foundation
import SwiftUI

struct JourneysCreate: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var date = Date.now
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                }
                Section {
                    DatePicker("Start Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .frame(maxHeight: 400)
                }
                
                Section {
                    Button("Save") {
                        let newJourney = Journey(context: moc)
                        newJourney.name = name
                        newJourney.startDate = date
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Journey")
        }
    }
}

#Preview {
    JourneysCreate()
}
