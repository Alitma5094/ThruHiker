//
//  ListJourneys.swift
//  ThruHiker
//
//  Created by Drew Litman on 6/22/23.
//

import SwiftUI
import SwiftData

struct JourneysList: View {
    @State private var showAddSheet = false
    @Query private var journeys: [Journey]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(journeys) { journey in
                    NavigationLink {
                        JourneysDetail(journey: journey)
                    } label: {
                        Text(journey.name)
                    }
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let item = journeys[index]
                        context.delete(item)
                        do {
                            try context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet.toggle()
                    } label: {
                        Label("Add Journey", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Journeys")
            .sheet(isPresented: $showAddSheet) {
                JourneysCreate()
            }
        }
    }
}


#Preview {
    JourneysList()
}
