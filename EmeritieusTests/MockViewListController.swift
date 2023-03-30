//
//  MockViewListController.swift
//  EmeritieusTests
//
//  Created by kandavel on 30/03/23.
//

import Foundation
import UIKit
@testable import Emeritieus
class  MockViewListController: RestaurantListViewProtocol {
    
    var isInvokedReloadData = false
    var isInvokedShowLoadingView = false
    var isInvokedHideLoadingView = false
    var isInvokedSetTitle = false
    var isInvokedSetupTableView = false
    var isInvokedSetupUI = false
    var isShowToastMessage = false
    
    func reloadData() {
        isInvokedReloadData = true
    }
    
    func showLoadingView() {
        isInvokedShowLoadingView = true
    }
    
    func hideLoadingView() {
        isInvokedHideLoadingView = true
    }
    
    func setTitle(_ title: String) {
        isInvokedSetTitle = true
    }
    
    func setupSearchControllerView() {
    
    }
    
    func setupCollectionView() {
        isInvokedSetupTableView  = true
    }
    
    func setupSearchBar() {
        
    }
    
    func setupUI(isHidden: Bool) {
        
    }
    
    func searchTextChanged(_ text: String) {
        
    }
    
    func showToastMessage(message: String) {
        isShowToastMessage  = true
    }
    
    func getViewWidth() -> CGFloat {
        return 44.0
    }
}

