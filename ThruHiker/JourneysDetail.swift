//
//  JourneysDetail.swift
//  ThruHiker
//
//  Created by Drew Litman on 7/7/23.
//

import SwiftUI

struct JourneysDetail: View {
    let journey: Journey
    let database = Database()
    var locations: [TrailLocation] {
        database.loadSavedLocations(inputLocations: journey.unwrappedLocations)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if locations.count > 0 {
                    EditButton()
                    List {
                        ForEach(locations) { location in
                            HStack {
                                ZStack {
                                    Image(systemName: markerSystemImage(for: location.type))
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(8)
                                        .background(Circle().foregroundColor(markerColor(for: location.type)))
                                }
                                VStack(alignment: .leading) {
                                    Text(location.name)
                                    Text(location.type.rawValue.capitalized)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                } else {
                    Text("To add a location, select a marker on the map.")
                }
            }
            .navigationTitle(journey.unwrappedName)
        }
    }
    
    private func markerSystemImage(for type: TrailLocationType) -> String {
        switch type {
        case .campsite:
            return "tent.fill"
        case .privie:
            return "toilet.fill"
        case .shelter:
            return "house.lodge.fill"
        case .vista:
            return "mountain.2.fill"
        }
    }
    
    private func markerColor(for type: TrailLocationType) -> Color {
        switch type {
        case .campsite:
            return .red
        case .privie:
            return .blue
        case .shelter:
            return .green
        case .vista:
            return .yellow
        }
    }
}

//#Preview {
//    JourneysDetail(journey: Journey(name: "Demo Journey", startDate: Date.now, locations: []))
//}
