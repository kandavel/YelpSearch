//
//  RestaurantDetailRouter.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation
import UIKit

protocol RestaurantDetailRouterProtocol {
    
}

class  RestaurantDetailRouter {
    
    weak var viewController : RestaurantDetailVC?
    
    static func navigateToDetailScreen(business : Business) -> UIViewController {
        let view = RestaurantDetailVC()
        let interactor : RestaurantDetailInteractorProtocol =  RestaurantDetailInteractor()
        let networkManager : NetworkManagerProtocol =   NetworkManager.shared
        let router = RestaurantDetailRouter()
        let presenter  :  RestaurantDetailInteractorOutputprotocol & RestaurantDetailPresentorProtocol =  RestaurantDetailPresentor(view: view, router: router, interactor: interactor, restaurantInfo: business)
        view.presentor = presenter
        interactor.output = presenter
        interactor.networkManager = networkManager
        router.viewController = view
        return view
    }
}

extension RestaurantDetailRouter : RestaurantDetailRouterProtocol {
    
}
