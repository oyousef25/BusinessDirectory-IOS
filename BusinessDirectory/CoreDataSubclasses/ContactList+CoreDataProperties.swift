//
//  ContactList+CoreDataProperties.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-24.
//
//

import Foundation
import CoreData


extension ContactList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactList> {
        return NSFetchRequest<ContactList>(entityName: "ContactList")
    }

    @NSManaged public var companyName: String?
    @NSManaged public var contactId: Int32
    @NSManaged public var contactLatitude: Double
    @NSManaged public var contactLogo: String?
    @NSManaged public var contactLongitude: Double
    @NSManaged public var contactName: String?
    @NSManaged public var contactNumber: String?
    @NSManaged public var contactProducts: [String]?

}

extension ContactList : Identifiable {

}
