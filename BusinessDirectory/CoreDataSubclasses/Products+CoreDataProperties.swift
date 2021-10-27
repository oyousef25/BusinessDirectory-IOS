//
//  Products+CoreDataProperties.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-27.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var productName: String?
    @NSManaged public var contactList: ContactList?

}

extension Products : Identifiable {

}
