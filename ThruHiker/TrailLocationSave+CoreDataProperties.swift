//
//  TrailLocationSave+CoreDataProperties.swift
//  ThruHiker
//
//  Created by Drew Litman on 7/10/23.
//
//

import Foundation
import CoreData


extension TrailLocationSave {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrailLocationSave> {
        return NSFetchRequest<TrailLocationSave>(entityName: "TrailLocationSave")
    }

    @NSManaged public var objectid: String?
    @NSManaged public var type: String?
    @NSManaged public var index: Int16
    @NSManaged public var journey: Journey?
    
    public var unwrappedObjectid: String {
        objectid ?? "0"
    }
    
    public var unwrappedTypeString: String {
        type ?? "campsite"
    }

}

extension TrailLocationSave : Identifiable {

}
