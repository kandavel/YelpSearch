//
//  BaseViewController.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title:String, message:String) {
        print("Error")
    }
    
    func showToastMessage(message: String) {
        let alertDisapperTimeInSeconds = 5.0
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + alertDisapperTimeInSeconds) {
          alert.dismiss(animated: true)
        }
    }
}
