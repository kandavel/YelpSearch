//
//  RestaurantListService.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation
enum RestaurantService  {
    case search(latitude : String,longitiude : String,query : String)
    case detail(id : String)
}

extension RestaurantService : APIRouter {
    var request: URLRequest? {
        switch self {
        case .search :
           return request(forEndpoint: "\(versionPath)/search")
        case .detail(let id) :
            return request(forEndpoint: "\(versionPath)/\(id)")
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let latitude, let longitiude,let query):
            return  [
                URLQueryItem(name: "term", value: "restaurants"),
                URLQueryItem(name: "latitude", value: latitude),
                URLQueryItem(name: "longitude", value: longitiude),
                URLQueryItem(name: "query", value: query)
            ]
        case .detail(id: _):
            return nil
        }
    }
}
