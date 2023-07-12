//
//  LocationDetailView.swift
//  ThruHiker
//
//  Created by Drew Litman on 6/21/23.
//

import SwiftUI
import SwiftData

struct LocationDetailView: View {
    let site: TrailLocation
    @State private var showingDialog = false
    @Query private var journeys: [Journey]
    
    
    var colums = [
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        NavigationStack{
            VStack {
                Button("Add to Journey") {
                    showingDialog = true
                }
                Text(site.type.rawValue.capitalized)
                Text("Latitude: \(site.latitude)")
                Text("Longitude: \(site.longitude)")
                
                ScrollView {
                    LazyVGrid(columns: colums, spacing: 10) {
                        ForEach(site.images, id: \.self) { photo in
                            AsyncImage(url: photo) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(5)
                            } placeholder: {
                                ProgressView()
                            }
                        }.padding(5)
                    }
                }
            }
            
            .navigationTitle(site.name)
            .navigationBarTitleDisplayMode(.inline)
            .confirmationDialog("Select a journey", isPresented: $showingDialog) {
                ForEach(journeys) { journey in
                    Button(journey.name) {
                        journey.locations.append(TrailLocationSave(objectid: site.objectid, name: site.name, latitude: site.latitude, longitude: site.longitude, type: site.type.rawValue, images: site.images))
                    }
                }
                
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

//#Preview {
//    LocationDetailView(site: TrailLocation(objectid: 3, name: "Liberty Springs Campsite", latitude: 44.1179349298, longitude: -71.6468715962, type: .campsite, images: [
//        URL(string: "https://drive.google.com/uc?export=view&id=1FIUCH0HZYfwXkzYXY09gQh6iS15RiNgH"),
//        URL(string: "https://drive.google.com/uc?export=view&id=1IpM9RmuzuNlpig8DC817KyTnwMxDVgEO"),
//        URL(string: "https://drive.google.com/uc?export=view&id=1CLegasB56_8UddOzjtLcJc0SUs7rPaxt"),
//        URL(string: "https://drive.google.com/uc?export=view&id=1oBxQtdwBr7FyRnTKBYxifnD7BC9Wojf5"),
//        URL(string: "https://drive.google.com/uc?export=view&id=1GdunLbuhgFapfk_D80i32QKYVxqosNSJ")]))
//}
