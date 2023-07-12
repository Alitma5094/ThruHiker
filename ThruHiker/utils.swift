//
//  utils.swift
//  ThruHiker
//
//  Created by Drew Litman on 7/12/23.
//

import Foundation
import SwiftUI

func getSavedTrailLocations(
    _ locations: [TrailLocationSave]
) -> [TrailLocation] {
    var items: [TrailLocation] = []
    for item in locations {
        items.append(
            TrailLocation(
                objectid: item.objectid,
                name: item.name,
                latitude: item.latitude,
                longitude: item.longitude,
                type: TrailLocationType(
                    rawValue: item.type
                )!,
                images: item.images
            )
        )
    }
    return items
}


func markerSystemImage(
    for type: TrailLocationType
) -> String {
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

func markerColor(
    for type: TrailLocationType
) -> Color {
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
