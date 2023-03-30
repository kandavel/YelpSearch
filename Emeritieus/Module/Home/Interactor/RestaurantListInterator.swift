//
//  RestaurantListInterator.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation

protocol RestaurantListInteratorProtocol: AnyObject {
    func fetchRestaurants(latitude : String,longititude : String,searchText : String)
    var output : RestaurantListInteratorOutputProtocol? {get set}
    var networkManager : NetworkManagerProtocol? {get set}
}

protocol RestaurantListInteratorOutputProtocol: AnyObject {
    func fetchRestaurantListOutput(result : ResultCallback<BusinessInfo>)
}

class  RestaurantListInterator {
    var output : RestaurantListInteratorOutputProtocol?
    var networkManager : NetworkManagerProtocol?
}

extension RestaurantListInterator : RestaurantListInteratorProtocol {
    func fetchRestaurants(latitude: String, longititude: String, searchText: String) {
        let urlRequest : APIRouter  = RestaurantService.search(latitude: latitude, longitiude: longititude, query: searchText)
        networkManager?.request(urlRequest, decodeToType: BusinessInfo.self, completionHandler: { result in
            self.output?.fetchRestaurantListOutput(result: result)
        })
    }
}

extension RestaurantListInterator : NetworkReachable  {
    
}
