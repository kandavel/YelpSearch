//
//  RestaurantDetailInteractor.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation

protocol RestaurantDetailInteractorProtocol : AnyObject {
    var networkManager : NetworkManagerProtocol? {get set}
    var output : RestaurantDetailInteractorOutputprotocol? {get set}
    func fetchRestaurantDetailInfo(id : String)
}

protocol RestaurantDetailInteractorOutputprotocol : AnyObject {
    func fetchRestaurantDetailOutput<T : Codable>(result : ResultCallback<T>)
}

class RestaurantDetailInteractor {
    var networkManager : NetworkManagerProtocol?
    var output : RestaurantDetailInteractorOutputprotocol?
}

extension RestaurantDetailInteractor : RestaurantDetailInteractorProtocol,NetworkReachable {
    func fetchRestaurantDetailInfo(id: String) {
        networkManager?.request(RestaurantService.detail(id: id), decodeToType: RestaurantDetail.self, completionHandler: { [weak self] (result)  in
            self?.output?.fetchRestaurantDetailOutput(result: result)
        })
    }
}
