//
//  ChatTableViewCell.swift
//  BlinqPay
//
//  Created by ULU on 23/05/2023.
//

import UIKit

@available(iOS 13.0, *)
final class ChatTableViewCell: BaseTableViewCell {
    
    fileprivate let avatarImageView = UIImageView(image: UIImage(systemName: "person"), size: 60, cornerRadius: 30)
    fileprivate let nameLabel = UILabel(text: "Smith Mathew", font: .productSansBold(size: 18), color: .primaryTextColor, alignment: .left)
    fileprivate lazy var notificationCountView = UIView(subviews: [notificationCount], size: 20, backgroundColor: .primaryGreen, radius: 10)
    fileprivate let notificationCount = UILabel(text: "2", font: .productSansBold(size: 10), color: .white, alignment: .center)
    fileprivate let messageLabel = UILabel(text: "Hi, David. Hope you’re doing....", font: .productSansBold(size: 16), color: .primaryGrey, alignment: .left)
    fileprivate lazy var nameNotificationStackView = HorizontalStackView(arrangedSubviews: [nameLabel, notificationCountView], distribution: .fillProportionally)
    fileprivate let timestampLabel = UILabel(text: "29 mar", font: .productSansRegular(size: 14), color: .primaryGrey, alignment: .right)
    fileprivate lazy var nameNotificationTimestampeStackView = HorizontalStackView(arrangedSubviews: [nameNotificationStackView, timestampLabel])
    fileprivate lazy var labelsStackView = VerticalStackView(arrangedSubviews: [nameNotificationTimestampeStackView, messageLabel])
    fileprivate lazy var containerView = UIView(subviews: [avatarImageView, labelsStackView])
    fileprivate let separatorView = UIView(height: 1, backgroundColor: .clear)
    
    override func setup() {
        super.setup()
        with(containerView) {
            _addSubviews($0, separatorView)
            $0.anchor(top: _topAnchor, leading: _leadingAnchor, trailing: _trailingAnchor)
        }
        
        with(avatarImageView) {
            $0.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor)
        }
        
        with(labelsStackView) {
            $0.anchor(top: avatarImageView.topAnchor, leading: avatarImageView.trailingAnchor, bottom: avatarImageView.bottomAnchor, trailing: containerView.trailingAnchor, padding: ._init(top: 0, left: 15, bottom: 0, right: 0))
        }
        
        with(notificationCount) {
            $0.centerInSuperview()
        }
        
        separatorView.anchor(top: containerView.bottomAnchor, leading: containerView.leadingAnchor, bottom: _bottomAnchor, trailing: containerView.trailingAnchor, padding: ._init(top: 0, left: 0, bottom: 10, right: 0))
    }
}
