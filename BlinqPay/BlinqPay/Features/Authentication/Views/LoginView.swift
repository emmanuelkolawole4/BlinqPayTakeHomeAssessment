//
//  LoginView.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class LoginView: BaseScrollView {
    
    var loginTapHandler: StringParamHandler?
    
    fileprivate let loginText = UILabel(text: Constants.LOGIN, font: .productSansBold(size: 30), alignment: .left, adjustsFontSizeToFitWidth: false)
    fileprivate let pleaseEnterUsernameSubtitleText = UILabel(text: Constants.PLEASE_ENTER_YOUR_USERNAME, font: .productSansRegular(size: 15), numberOfLines: 0, color: .secondaryTextColor, alignment: .left, adjustsFontSizeToFitWidth: false)
    fileprivate let usernameTextField = CustomTextField(title: Constants.USERNAME, placeholder: Constants.ENTER_USERNAME, validationType: .username)
    
    fileprivate lazy var logInButton: CustomButton = {
        CustomButton(title: Constants.LOG_IN, textColor: .white, height: 50, tapAction: handleLogInButtonTapped)
    }()
    
    override func addConstraints() {
        super.addConstraints()
        _addSubviews(loginText, pleaseEnterUsernameSubtitleText, usernameTextField, logInButton)
        loginText.anchor(top: _topAnchor, leading: _leadingAnchor, trailing: _trailingAnchor, padding: ._init(top: 90, left: 35, right: 35))
        pleaseEnterUsernameSubtitleText.anchor(top: loginText.bottomAnchor, leading: loginText.leadingAnchor, trailing: loginText.trailingAnchor, padding: ._init(top: 8))
        usernameTextField.anchor(top: pleaseEnterUsernameSubtitleText.bottomAnchor, leading: loginText.leadingAnchor, trailing: loginText.trailingAnchor, padding: ._init(top: 20))
        logInButton.anchor(top: usernameTextField.bottomAnchor, leading: loginText.leadingAnchor, trailing: loginText.trailingAnchor, padding: ._init(top: 32))
    }
    
    fileprivate func handleLogInButtonTapped() {
        if usernameTextField.isValid {
            loginTapHandler?(usernameTextField.text)
        }
    }

}
