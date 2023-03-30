//
//  RestaurantDetail.swift
//  Emeritieus
//
//  Created by kandavel on 27/03/23.
//

import Foundation
// MARK: - RestaurantDetail
struct RestaurantDetail: Codable {
    var id, alias, name: String?
    var imageURL: String?
    var isClaimed, isClosed: Bool?
    var url: String?
    var phone, displayPhone: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var location: Location?
    var photos: [String]?
    var price: String?
    var transactions: [String]?

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url, phone
        case displayPhone = "display_phone"
        case reviewCount = "review_count"
        case categories, rating, location, photos, transactions
    }
}

