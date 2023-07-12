//
//  JourneysDetail.swift
//  ThruHiker
//
//  Created by Drew Litman on 7/7/23.
//

import SwiftUI
import SwiftData

struct JourneysDetail: View {
    let journey: Journey
    let locations: [TrailLocation]
    @Environment(\.modelContext) private var context
    
    init(journey: Journey) {
        self.journey = journey
        self.locations = getSavedTrailLocations(journey.locations)
        print(locations)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if locations.count > 0 {
                    List {
                        ForEach(locations) { location in
                            NavigationLink {
                                LocationDetailView(site: location)
                            } label: {
                                HStack {
                                    ZStack(alignment: .center) {
                                        Image(systemName: markerSystemImage(for: location.type))
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Circle().foregroundColor(markerColor(for: location.type)))
                                    }
                                    .frame(width: 10, height: 10)
                                    .padding(.horizontal, 15)
                                    VStack(alignment: .leading) {
                                        Text(location.name)
                                        Text(location.type.rawValue.capitalized)
                                            .font(.subheadline)
                                    }
                                }
                            }
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                do {
                                    let item = journey.locations[index]
                                    context.delete(item)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        })
                    }
                    .toolbar {
                        EditButton()
                    }
                } else {
                    Text("To add a location, select a marker on the map.")
                }
            }
            .navigationTitle(journey.name)
        }
    }
}

#Preview {
    JourneysDetail(journey: Journey(name: "Demo Journey", startDate: Date.now))
}
