//
//  RestaurantListVC.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation
import UIKit

protocol RestaurantListViewProtocol : AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
    func setupSearchControllerView()
    func setupCollectionView()
    func setupSearchBar()
    func setupUI(isHidden: Bool)
    func searchTextChanged(_ text: String)
    func showToastMessage(message : String)
    func getViewWidth() -> CGFloat
}

class RestaurantListVC: BaseViewController,LoadingShowable {
    
    // MARK: -IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: -Variable
    var presenter: RestaurantListPresentorProtocol!
    var searchController:UISearchController!
    private weak var timer: Timer?
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Restaurants.."
        searchBar.delegate = self
        searchBar.tintColor = .black
        searchBar.barTintColor = .white
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        return searchBar
    }()
    
    init() {
        super.init(nibName: String(describing: RestaurantListVC.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /// This function invalidate the timer when  there is input stroke from the user
    fileprivate func invalidateTimer(){
        weak var weakSelf = self
        weakSelf?.timer?.invalidate()
        weakSelf?.timer = nil
    }
    
    fileprivate func startTimer(){
        self.setTimer()
    }
    
    /// This function set timer, that ill get invoked after  3 seconds, when no input recived from the user
    fileprivate func setTimer() {
        weak var weakSelf = self
        weakSelf?.timer?.invalidate()
        weakSelf?.timer = nil
        weakSelf?.timer = Timer.scheduledTimer(timeInterval: 3.0, target: weakSelf ?? self, selector: #selector(weakSelf?.searchFilteredData), userInfo: nil, repeats: false)
    }
    
    @objc override func showToastMessage(message: String) {
        self.showToastMessage(message: message)
    }
    
    @objc func  searchFilteredData() {
        
    }
    
    deinit{
        
    }
    
}

extension RestaurantListVC : RestaurantListViewProtocol {
    
    func setupSearchControllerView() {
        
    }
    
    func getViewWidth() -> CGFloat {
        self.collectionView.frame.width
    }
    
    func searchTextChanged(_ text: String) {
        if text.count >= 3 {
            self.presenter.searchTextChanged(text)
        }
        else if text.isEmpty {
            self.presenter.resetFilterSearch()
        }
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
    func showLoadingView() {
        self.showLoading()
    }
    
    func hideLoadingView() {
        self.hideLoading()
    }
    
    func setTitle(_ title: String) {
        self.title  =  title
    }
    
    func setupTableView() {
        
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
        self.collectionView.register(cellType: RestaurantListCell.self)
    }
    
    func setupSearchBar() {
        
    }
    
    func setupUI(isHidden: Bool) {
        
    }
}
extension RestaurantListVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.getItemSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RestaurantListCell.self), for: indexPath) as? RestaurantListCell {
            if let business  =  presenter.didFetchItemAtIdex(indexPath: indexPath) {
                cell.cellViewModel  =  RestaurantListCellViewModel(view: cell, business: business)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
            header.addSubview(searchBar)
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
            searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
            searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
            searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
}

extension RestaurantListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(index: indexPath.row)
    }
}

extension RestaurantListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextChanged(searchText)
   }
}
