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
    @Environment(\.modelContext) var context
    
    @State private var name = ""
    @State private var date = Date.now
    
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
                        context.insert(Journey(name: name, startDate: date))
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
        .modelContainer(for: Journey.self)
}
