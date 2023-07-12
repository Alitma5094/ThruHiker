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
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var journeys: FetchedResults<Journey>
    
    var body: some View {
        NavigationStack {
            VStack {
                if (journeys.count > 0) {
                    List {
                        ForEach(journeys) { journey in
                            NavigationLink {
                                JourneysDetail(journey: journey)
                            } label: {
                                Text(journey.unwrappedName)
                            }
                        }
                        .onDelete(perform: deleteJourney)
                    }
                } else {
                    Button("Add a Journeys") {
                        showAddSheet = true
                    }
                }
            }
            .navigationTitle("Journeys")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                JourneysCreate()
            }
        }
    }
    
    func deleteJourney(offsets: IndexSet) {
        // TODO: Delete Journey
//        withAnimation {
//            for index in offsets {
//                context.delete(journeys[index])
//            }
//        }
    }
}


#Preview {
    JourneysList()
}
