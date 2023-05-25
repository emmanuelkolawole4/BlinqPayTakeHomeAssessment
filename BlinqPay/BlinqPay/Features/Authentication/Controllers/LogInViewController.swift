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
                self?.viewModel.login(with: username)
            }
        }
    }
    
    override func setChildViewControllerObservers() {
        super.setChildViewControllerObservers()
        observeAuthNavRoute()
        observeAuthErrorMessage()
    }
    
    fileprivate func observeAuthNavRoute() {
        viewModel.authNavRoute.bind { [weak self] route in
            if route == .home {
                let vc = DashboardTabController()
                vc.modalPresentationStyle = .fullScreen
                self?.show(vc, sender: self)
            }
        }.disposed(by: disposeBag)
    }
    
    fileprivate func observeAuthErrorMessage() {
        viewModel.authErrorMessage.bind { message in
            print("error: " + message)
        }.disposed(by: disposeBag)
    }

}
