//
//  ChannelListRouter.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation

protocol RestaurantListRouterRouterProtocol: AnyObject {
    func navigate(_ route: HomeRoutes)
}

enum HomeRoutes {
    case detail(restaurant : Business)
}

final class RestaurantListRouter {
    
    weak var viewController: RestaurantListVC?
    
    static func createModule() -> RestaurantListVC {
        let view = RestaurantListVC()
        let interactor : RestaurantListInteratorProtocol  = RestaurantListInterator()
        let router   = RestaurantListRouter()
        let networkManager : NetworkManagerProtocol =  NetworkManager.shared
        let presenter : RestaurantListPresentorProtocol & RestaurantListInteratorOutputProtocol = RestaurantListPresentor(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        interactor.networkManager = networkManager
        router.viewController = view
        return view
    }
}

extension RestaurantListRouter: RestaurantListRouterRouterProtocol {
    
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .detail(let business):
            let detailVC  = RestaurantDetailRouter.navigateToDetailScreen(business: business)
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
            break
        }
    }
}
