//
//  File.swift
//  Emeritieus
//
//  Created by kandavel on 28/03/23.
//

import Foundation

protocol ListCellViewModelProtocol: AnyObject {
    func load()
}

class RestaurantListCellViewModel {
    weak var view: RestaurantListUIProtocol?
    let business: Business

    init(view: RestaurantListUIProtocol?, business: Business) {
        self.view = view
        self.business = business
    }
}

extension RestaurantListCellViewModel: ListCellViewModelProtocol {
    func load() {
        view?.setupUI(title: business.name ?? "", imageURL: business.imageURL ?? "", rating: business.rating ?? 0.0, price: business.price?.rawValue ?? "")
    }
}
