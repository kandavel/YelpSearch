//
//  Restaurant.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation


// MARK: - ChannelProgram
struct BusinessInfo: Codable {
    var businesses: [Business]?
    var total: Int?
    var region: Region?
}

// MARK: - Business
struct Business: Codable {
    var id, alias, name: String?
    var imageURL: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Center?
    var transactions: [Transaction]?
    var location: Location?
    var phone, displayPhone: String?
    var distance: Double?
    var price: Price?

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories, rating, coordinates, transactions, location, phone
        case displayPhone = "display_phone"
        case distance, price
    }
}

// MARK: - Category
struct Category: Codable {
    var alias, title: String?
}

// MARK: - Center
struct Center: Codable {
    var latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
    var address1: String?
    var address2: String?
    var city: City?
    var zipCode: String?
    var country: Country?
    var displayAddress: [String]?

    enum CodingKeys: String, CodingKey {
        case address1, address2, city
        case zipCode = "zip_code"
        case country
        case displayAddress = "display_address"
    }
}

enum City: String, Codable {
    case sanFrancisco = "San Francisco"
}

enum Country: String, Codable {
    case us = "US"
}

enum Price: String, Codable {
    case empty = "$$"
    case price = "$$$$"
    case purple = "$$$"
}

enum Transaction: String, Codable {
    case delivery = "delivery"
    case pickup = "pickup"
    case restaurantReservation = "restaurant_reservation"
}

// MARK: - Region
struct Region: Codable {
    var center: Center?
}
