//
//  HomeViewController.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class HomeViewController: BaseViewController<HomeView, IHomeViewModel> {
    
    override func configureViews() {
        super.configureViews()
        setBackgroundColor()
        title = "Feed"
    }

}
