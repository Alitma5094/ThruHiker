//
//  Journey+CoreDataProperties.swift
//  ThruHiker
//
//  Created by Drew Litman on 7/10/23.
//
//

import Foundation
import CoreData


extension Journey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Journey> {
        return NSFetchRequest<Journey>(entityName: "Journey")
    }

    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var locations: NSSet?
    
    public var unwrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var unwrappedStartDate: Date {
        startDate ?? Date.now
    }
    
    public var unwrappedLocations: [TrailLocationSave] {
        let set = locations as? Set<TrailLocationSave> ?? []
        return set.sorted {
            $0.index < $1.index
        }
    }

}

// MARK: Generated accessors for locations
extension Journey {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: TrailLocationSave)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: TrailLocationSave)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}

extension Journey : Identifiable {

}
