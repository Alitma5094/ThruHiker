//
//  Database.swift
//  ThruHiker
//
//  Created by Drew Litman on 6/23/23.
//

import Foundation
import SQLite
import CoreLocation
import SwiftData

func extractFileID(from url: String) -> String? {
    guard let range = url.range(of: #"(?<=/d/|id=|rs/)[^/&#\?]+"#, options: .regularExpression) else {
        return nil
    }
    
    let fileID = url[range]
    return String(fileID)
}

func formatGoogleDriveURL(withID fileID: String) -> String {
    let baseURL = "https://drive.google.com/uc?export=view&id="
    let formattedURL = baseURL + fileID
    return formattedURL
}

class Database: ObservableObject {
    private let connection: Connection

    init() {
        let path = Bundle.main.path(forResource: "data", ofType: "geodatabase")!
        
        guard let db = try? Connection(path, readonly: true) else {
            fatalError("Unable to find database")
        }
        connection = db
    }
    
    func fetchLocations(inputLocations: [TrailLocationType]) -> [TrailLocation] {
        var items = [TrailLocation]()
        
        let tables = [TrailLocationType.campsite: "Campsites",
                      TrailLocationType.shelter: "Shelters",
                      TrailLocationType.vista: "Vistas",
                      TrailLocationType.privie: "Privies"]
        
        do {
            for input in inputLocations {
                
                let campsites = Table(tables[input]!)
                let query = campsites.select(*)
                for campsite in try connection.prepare(query) {
                    
                    let objectid = try! campsite.get(Expression<Int>("OBJECTID"))
                    let name = try! campsite.get(Expression<String>("Name"))
                    let latitude = try! campsite.get(Expression<String>("Latitude"))
                    let longitude = try! campsite.get(Expression<String>("Longitude"))
                    let type = input
                    
                    var images = [URL]()
                    
                    let photoKeys = ["Photo1", "Photo2", "Photo3", "Photo4", "Photo5", "Photo6", "Photo7", "Photo8", "Photo9", "Photo10"]
                    
                    for key in photoKeys {
                        do {
                            if let fileID = extractFileID(from: try campsite.get(Expression<String>(key))) {
                                if let formattedURL = URL(string: formatGoogleDriveURL(withID: fileID)) {
                                    images.append(formattedURL)
                                }
                            }
                        } catch {
                            print("Photo Error: \(error)")
                        }
                    }
                    
                    let trailLocation = TrailLocation(objectid: objectid, name: name, latitude: Double(latitude)!, longitude: Double(longitude)!, type: type, images: images)
                    items.append(trailLocation)
                }
            }
        } catch {
            print("Error: \(error)")
        }
        
        return items
    }
}

