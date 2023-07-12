//
//  Types.swift
//  ThruHiker
//
//  Created by Drew Litman on 7/7/23.
//

import Foundation
import CoreLocation

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


//@Model
//class Journey {
//    var name: String
//    var startDate: Date
//    var locations: [Dictionary<String, String>]
//    
//    init(name: String, startDate: Date, locations: [TrailLocation]) {
//        self.name = name
//        self.startDate = startDate
//        
//        for location in locations {
//            self.locations.append(["type": location.type.rawValue, "id": String(location.objectid)])
//        }
////        self.locations = locations
//    }
//}
