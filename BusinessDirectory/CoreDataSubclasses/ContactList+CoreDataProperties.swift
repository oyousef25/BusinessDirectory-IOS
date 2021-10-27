//
//  ContactList+CoreDataProperties.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-27.
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
    @NSManaged public var contactProducts: String?
    @NSManaged public var product: NSSet?

}

// MARK: Generated accessors for product
extension ContactList {

    @objc(addProductObject:)
    @NSManaged public func addToProduct(_ value: Products)

    @objc(removeProductObject:)
    @NSManaged public func removeFromProduct(_ value: Products)

    @objc(addProduct:)
    @NSManaged public func addToProduct(_ values: NSSet)

    @objc(removeProduct:)
    @NSManaged public func removeFromProduct(_ values: NSSet)

}

extension ContactList : Identifiable {

}
