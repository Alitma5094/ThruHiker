//
//  ContentView.swift
//  ThruHiker
//
//  Created by Drew Litman on 6/7/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let database = Database()
    @State private var showingTypeDialog = false
    @State private var selectedLocations: [TrailLocation]
    @State private var selectedPoint: TrailLocation?
    
    @State private var showJourneysSheet = false
    
    init() {
        self.selectedLocations = database.fetchLocations(inputLocations: [TrailLocationType.campsite])
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(selection: $selectedPoint) {
                UserAnnotation()
                ForEach(selectedLocations) { location in
                    Marker(location.name, systemImage: markerSystemImage(for: location.type), coordinate: location.coordinate)
                        .tint(markerColor(for: location.type))
                        .tag(location)
                }
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    HStack {
                        Button {
                            selectedLocations = database.fetchLocations(inputLocations: [TrailLocationType.campsite])
                        } label: {
                            Label("Campsites", systemImage: "tent.fill")
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button {
                            selectedLocations = database.fetchLocations(inputLocations: [TrailLocationType.shelter])
                        } label: {
                            Label("Shelters", systemImage: "house.lodge.fill")
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button {
                            selectedLocations = database.fetchLocations(inputLocations: [TrailLocationType.privie])
                        } label: {
                            Label("Privies", systemImage: "toilet.fill")
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button {
                            selectedLocations = database.fetchLocations(inputLocations: [TrailLocationType.vista])
                        } label: {
                            Label("Vistas", systemImage: "mountain.2.fill")
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button {
                            showJourneysSheet = true
                        } label: {
                            Label("Journeys", systemImage: "signpost.right.and.left.fill")
                        }
                        .buttonStyle(.bordered)
                    }
                    .labelStyle(.iconOnly)
                    .padding(.top)
                }
                Spacer()
            }
            .background(.thinMaterial)
        }
        .sheet(item: $selectedPoint) { item in
            LocationDetailView(site: item)
        }
        .sheet(isPresented: $showJourneysSheet) {
            JourneysList()
        }
    }
}

#Preview {
    ContentView()
}
