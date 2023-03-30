//
//  RestaurantListPresentor.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation
import UIKit

protocol RestaurantListPresentorProtocol: AnyObject {
    func viewDidLoad()
    func numberOfRows() -> Int
    func didSelectRowAt(index: Int)
    func numberOfItems() -> Int
    func didSelectItemAt(index: Int)
    func searchTextChanged(_ text:String)
    func resetFilterSearch()
    func setSearchTextState()
    func didFetchItemAtIdex(indexPath : IndexPath) -> Business?
    func getItemSize() -> CGSize
}

class RestaurantListPresentor {
    
    unowned var view: RestaurantListViewProtocol?
    let router: RestaurantListRouterRouterProtocol!
    let interactor: RestaurantListInteratorProtocol!
    
    private var list :  [Business] = []
    private var filteredList : [Business] = []
    var isFiltering : Bool  = false
    
    init(view: RestaurantListViewProtocol, router: RestaurantListRouterRouterProtocol, interactor: RestaurantListInteratorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}
extension RestaurantListPresentor : RestaurantListPresentorProtocol {
    func resetFilterSearch() {
        self.isFiltering  = false
        self.filteredList.removeAll()
        self.view?.reloadData()
    }
    
    func didFetchItemAtIdex(indexPath : IndexPath) -> Business? {
        if self.isFiltering {
            return self.filteredList[safe : indexPath.row]
        }
        else {
            return self.list[safe : indexPath.row]
        }
    }
    
    func viewDidLoad() {
        self.view?.showLoadingView()
        self.view?.setTitle("Yelp")
        self.view?.setupSearchBar()
        self.view?.setupCollectionView()
        self.fetchRestaurantList()
    }
    
    func fetchRestaurantList(latitude : String? =  "37.786882",longititude : String? =  "-122.399972",query : String? =  "Mourad Restaurant") {
        DispatchQueue.global(qos: .background).async {
            self.interactor.fetchRestaurants(latitude: latitude ?? "", longititude: longititude ?? "", searchText: query ?? "")
        }
    }
    
    func numberOfRows() -> Int {
        
        return 0
    }
    
    func didSelectRowAt(index: Int) {
        
        
    }
    
    func numberOfItems() -> Int {
        if self.isFiltering {
            return self.filteredList.count
        }
        else {
            return self.list.count
        }
    }
    
    func didSelectItemAt(index: Int) {
        if isFiltering {
            guard let business  = self.filteredList[safe : index]  else {return}
            router.navigate(HomeRoutes.detail(restaurant: business))
        }
        else {
            guard let business  = self.list[safe : index]  else {return}
            router.navigate(HomeRoutes.detail(restaurant: business))
        }
    }
    
    func setSearchTextState() {
        self.isFiltering = !(isFiltering)
    }
    
    func getFilteresRestaurantName(serachText : String) {
        self.filteredList  = self.list.filter({ business in
            let titleMatch = business.name!.range(of: serachText, options: NSString.CompareOptions.caseInsensitive)
            let alias = business.alias!.range(of: serachText, options: NSString.CompareOptions.caseInsensitive)
            return titleMatch != nil || alias != nil
        })
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
            self.view?.showToastMessage(message: "Internet connecions seems offline 🖥")
            break
        }
    }
    
    func updateData() {
        self.isFiltering  = false
        self.view?.hideLoadingView()
        DispatchQueue.main.async { [weak self] in
            self?.view?.reloadData()
        }
    }
    
    func getItemSize() -> CGSize {
        let size  = self.view?.getViewWidth() ?? CGFloat.zero
        return CGSize(width: size, height: 100)
    }
    
    func searchTextChanged(_ text: String) {
        getFilteresRestaurantName(serachText: text)
        setSearchTextState()
        self.view?.reloadData()
    }
}
extension RestaurantListPresentor : RestaurantListInteratorOutputProtocol {
    func fetchRestaurantListOutput(result: ResultCallback<BusinessInfo>) {
        switch result {
        case .success(let data):
            self.list = data.businesses ?? []
            updateData()
            break
        default:
            break
        }
    }
    
    
}


