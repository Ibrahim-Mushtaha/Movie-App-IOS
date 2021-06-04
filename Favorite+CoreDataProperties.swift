//
//  Favorite+CoreDataProperties.swift
//  Movie App
//
//  Created by Ibrahim Mushtaha on 04/06/2021.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var movie_id: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?

}

extension Favorite : Identifiable {

}
