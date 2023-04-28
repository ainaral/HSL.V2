//
//  UserPreferences+CoreDataProperties.swift
//  HSL.V2
//
//  Created by iosdev on 23.4.2023.
//
//

import Foundation
import CoreData


extension UserPreferences {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserPreferences> {
        return NSFetchRequest<UserPreferences>(entityName: "UserPreferences")
    }

    @NSManaged public var language: String?
    @NSManaged public var role: String?
    @NSManaged public var fullName: String?
    @NSManaged public var notications: Bool
    @NSManaged public var location: Bool

}

extension UserPreferences : Identifiable {

}
