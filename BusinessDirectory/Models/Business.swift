//
//  Business.swift
//  BusinessDirectory
//
//  Created by Omar Yousef on 2021-10-22.
//

import Foundation

//All albums
struct Businesses: Codable{
    var results: [Business]
}

//Album object to create a new instance of the object
struct Business: Codable{
    var id: Int?
    var businessName: String?
    var longitude: Double?
    var latitude: Double?
    var companyHead: String?
    var products: [String]
    var contactNumber: String?
    var companyLogo: String?
}
