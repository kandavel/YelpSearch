//
//  RestaurantDetailVC.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation
import UIKit

protocol RestaurantDetailViewProtocol  : AnyObject {
    func showViewLoading()
    func hideViewLoading()
    func updateUI()
    func showErrorState(messge : String)
    func setTitle(title : String)
    func setimageUrl()
    func setPhoneNumber()
    func SetReviewCount()
    func setRestaurantDetail()
}

class RestaurantDetailVC: BaseViewController,LoadingShowable {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var phoneNumberLabel : UILabel!
    @IBOutlet weak var reviewCountLabel : UILabel!
    // MARK: -Variable
    var presentor : RestaurantDetailPresentorProtocol!
    
    init() {
        super.init(nibName: String(describing: RestaurantDetailVC.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizerToLabel()
        presentor.viewDidLoad()
    }
    
    func addGestureRecognizerToLabel() {
        phoneNumberLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(callPhoneNumber))
        tapGesture.numberOfTapsRequired = 1
        self.phoneNumberLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func callPhoneNumber() {
        guard let phoneNumber  = self.presentor.getPhoneNumber()  else {return}
        phoneNumber.openTelephone()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        
    }
    
}
extension RestaurantDetailVC : RestaurantDetailViewProtocol {
    func updateUI() {
        setimageUrl()
        setPhoneNumber()
        setRestaurantDetail()
        SetReviewCount()
    }
    
    func showViewLoading() {
        self.showLoading()
    }
    
    func hideViewLoading() {
        self.hideLoading()
    }
    
    func showErrorState(messge: String) {
        self.showToastMessage(message: messge)
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func setimageUrl() {
        if let url  =  URL(string: self.presentor.getImageUrl() ?? "") {
            self.imageView.load(url: url, placeholder: UIImage(named: ""), cache: nil) { [weak self](image) in
                UIView.transition(with: self?.view ?? UIView(),
                duration: 0.3,
                options: [.curveEaseOut, .transitionCrossDissolve],
                animations: {
                    self?.imageView.image = image
                })
            }
        }
    }
    
    func setRestaurantDetail() {
        self.titleLabel.text =   "Name : \(self.presentor.getRestaurantTitleUrl() ?? "")"
    }
    
    func setPhoneNumber() {
        self.phoneNumberLabel.text  = "Phone :\(self.presentor.getPhoneNumber() ?? "")"
    }
    
    func SetReviewCount() {
        self.reviewCountLabel.text = "Review Count : \(self.presentor.getReviewCount() ?? "0")"
    }
}
