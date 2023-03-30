//
//  RestaurantDetailPresentor.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation

protocol RestaurantDetailPresentorProtocol : AnyObject {
    func viewDidLoad()
    func getImageUrl() -> String?
    func getRestaurantTitleUrl() -> String?
    func getReviewCount() -> String?
    func getPhoneNumber() -> String?
    
}

class RestaurantDetailPresentor {
    
    unowned var view: RestaurantDetailViewProtocol?
    let router: RestaurantDetailRouterProtocol!
    let interactor: RestaurantDetailInteractorProtocol!
    private var restaurantDetail : RestaurantDetail?
    private var restaurantinfo : Business?
    
    init(view: RestaurantDetailViewProtocol, router: RestaurantDetailRouterProtocol, interactor: RestaurantDetailInteractorProtocol,restaurantInfo : Business? = nil) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.restaurantinfo = restaurantInfo
    }
    
    func fetchRestaurantDetailinfo() {
        interactor.fetchRestaurantDetailInfo(id: restaurantinfo?.id ?? "")
    }
    
}

extension RestaurantDetailPresentor : RestaurantDetailPresentorProtocol {
    func viewDidLoad() {
        self.view?.showViewLoading()
        fetchRestaurantDetailinfo()
    }
    
    func getImageUrl() -> String? {
        return self.restaurantDetail?.imageURL
    }
    
    func getRestaurantTitleUrl() -> String? {
        let name   = self.restaurantDetail?.name
        return name
    }
    
    func getReviewCount() -> String? {
        let count  = "\(self.restaurantDetail?.reviewCount ?? 0)"
        return count
    }
    
    func getPhoneNumber() -> String? {
        let phoneNumber  =  self.restaurantDetail?.phone
        return phoneNumber
    }
    
    func handleErrorCases(error : NetworkError) {
        switch error {
        case .invalidRequest:
            break
        case .dataMissing:
            break
        case .endpointNotMocked:
            break
        case .mockDataMissing:
            break
        case .responseError( _):
            break
        case .parserError(_):
            break
        case .reachabilityError(_):
            self.view?.showErrorState(messge: "Internet connecions seems offline 🖥")
            break
        }
    }
    
    
}

extension RestaurantDetailPresentor : RestaurantDetailInteractorOutputprotocol {
    func fetchRestaurantDetailOutput<T>(result: ResultCallback<T>) where T : Decodable, T : Encodable {
        switch result {
        case .success(let data):
            if let decodedData =  data as? RestaurantDetail {
                self.restaurantDetail  = decodedData
                self.view?.hideViewLoading()
                self.view?.updateUI()
            }
            break
        case .failure(let error):
            handleErrorCases(error: error)
            break
        }
    }
}
