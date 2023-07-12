//
//  Types.swift
//  ThruHiker
//
//  Created by Drew Litman on 7/7/23.
//

import Foundation
import CoreLocation
import SwiftData

enum TrailLocationType: String {
    case campsite
    case privie
    case shelter
    case vista
}

struct TrailLocation: Identifiable, Hashable {
    let objectid: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let type: TrailLocationType
    let images: [URL?]
    
    var id: UUID {
        UUID()
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

@Model
final class TrailLocationSave {
    var objectid: Int
    var name: String
    var latitude: Double
    var longitude: Double
    var type: String
    var images: [URL?]
    @Relationship(inverse: \Journey.locations)
    
    init(objectid: Int, name: String, latitude: Double, longitude: Double, type: String, images: [URL?]) {
        self.objectid = objectid
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.type = type
        self.images = images
    }
    
}

@Model
final class Journey {
    var name: String
    var startDate: Date
    @Relationship(.cascade) var locations: [TrailLocationSave]
    
    init(name: String, startDate: Date) {
        self.name = name
        self.startDate = startDate
    }
}
