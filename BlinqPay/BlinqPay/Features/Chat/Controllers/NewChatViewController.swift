//
//  ChatViewController.swift
//  BlinqPay
//
//  Created by ULU on 23/05/2023.
//

import UIKit
import BottomPopup

@available(iOS 13.0, *)
class NewChatViewController: BottomPopupViewController {
        
    fileprivate let closeImageView = UIImageView(image: UIImage(systemName: "xmark.circle"), tintColor: .white, size: 20, cornerRadius: 10, backgroundColor: .primaryGrey)
    fileprivate let recepientUsernameLabel = UILabel(text: Constants.RECEPIENT_USERNAME, font: .productSansBold(size: 18), color: .primaryTextColor, alignment: .left)
    fileprivate let usernameTextField = CustomTextField(title: "", placeholder: Constants.ENTER_USERNAME, validationType: .username)
    
    fileprivate lazy var startChatButton: CustomButton = {
        CustomButton(title: Constants.START_CHAT, textColor: .white, height: 50, tapAction: handleStartChatButtonTapped)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        setBackgroundColor()
        addSubviews(closeImageView, recepientUsernameLabel, usernameTextField, startChatButton)
        closeImageView.anchor(top: topAnchor, trailing: trailingAnchor, padding: ._init(topBottom: 20, leftRight: 20))
        recepientUsernameLabel.anchor(top: closeImageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 30, bottom: 0, right: 30))
        usernameTextField.anchor(top: recepientUsernameLabel.bottomAnchor, leading: recepientUsernameLabel.leadingAnchor, trailing: recepientUsernameLabel.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        startChatButton.anchor(top: usernameTextField.bottomAnchor, leading: recepientUsernameLabel.leadingAnchor, bottom: bottomAnchor, trailing: recepientUsernameLabel.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 50, right: 0))
        
        closeImageView.animateViewOnTapGesture { [weak self] in
            self?.dismissViewController()
        }
    }
    
    fileprivate func handleStartChatButtonTapped() {
    }
    
    override var popupTopCornerRadius: CGFloat { 15 }
    
    override var popupHeight: CGFloat { 300 }
    
    override var popupPresentDuration: Double { 0.2 }
    
    override var popupDismissDuration: Double { 0.2 }
}
