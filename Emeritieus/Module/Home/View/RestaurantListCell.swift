//
//  RestaurantListCell.swift
//  Emeritieus
//
//  Created by kandavel on 26/03/23.
//

import Foundation
import UIKit

protocol RestaurantListUIProtocol: AnyObject {
    func setupUI(title: String, imageURL: String, rating: Double,price : String)
}

class RestaurantListCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var titleLable : UILabel!
    @IBOutlet weak var priceLable : UILabel!
    @IBOutlet weak var ratingLabel : UILabel!
    // MARK: -Variable
    var cellViewModel: ListCellViewModelProtocol! {
        didSet {
            cellViewModel.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

extension RestaurantListCell : RestaurantListUIProtocol {
    func setupUI(title: String, imageURL: String, rating: Double, price: String) {
        titleLable.text  = title
        ratingLabel.text  = "\(rating)"
        priceLable.text  =  price
        if let imageURL  = URL(string: imageURL) {
            imageView.load(url: imageURL, placeholder: UIImage(named: ""), completionhandler: { (image) in
                UIView.transition(with: self,
                duration: 0.3,
                options: [.curveEaseOut, .transitionCrossDissolve],
                animations: {
                    self.imageView.image = image
                })
            })
        }
    }
}
