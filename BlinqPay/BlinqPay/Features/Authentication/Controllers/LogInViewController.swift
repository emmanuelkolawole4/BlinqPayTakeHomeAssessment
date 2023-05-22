//
//  LogInViewController.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class LogInViewController: BaseViewController<LoginView, IAuthViewModel> {
    
    override func configureViews() {
        super.configureViews()
        kview.do {
            $0.loginTapHandler = { [weak self] username in
                let vc = DashboardTabController()
                vc.modalPresentationStyle = .fullScreen
                self?.show(vc, sender: self)
            }
        }
    }

}
