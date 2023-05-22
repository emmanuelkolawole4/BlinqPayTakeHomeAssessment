//
//  HomeCollectionViewCell.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class HomeCollectionViewCell: BaseCollectionViewCell {
    
    fileprivate let avatarImageView = UIImageView(image: UIImage(systemName: "person"), size: 45, cornerRadius: 10)
    fileprivate let nameLabel = UILabel(text: "Cynthia Kulmax", font: .productSansBold(size: 16), color: .primaryTextColor, alignment: .left)
    fileprivate let usernameLabel = UILabel(text: "@quenme", font: .productSansRegular(size: 11), color: .primaryGrey, alignment: .left)
    fileprivate let locationLabel = UILabel(text: "Lagos, Nigeria", font: .productSansRegular(size: 11), color: .primaryGrey, alignment: .left)
    fileprivate let timestampLabel = UILabel(text: "2m ago", font: .productSansRegular(size: 11), color: .primaryGrey, alignment: .left)
    fileprivate let postLabel = UILabel(text: "I was at Kaduna state yesterday after a stressful week just to relax and nature was very awesome. Getting to see these things...more", font: .productSansRegular(size: 11), color: .primaryGrey, alignment: .left)
    fileprivate let postImage = UIImageView(image: UIImage(systemName: "camera"), height: 245, cornerRadius: 6)
    fileprivate lazy var likesIconView = IconTextView(text: "25", font: .productSansRegular(size: 15), placeholderIcon: UIImage(systemName: "heart"), iconTint: .primaryGreen, iconTextAlignment: .iconLeft, iconSize: 15, textColor: .primaryGrey, textAlignment: .left, contentStackAlignment: .center)
    fileprivate lazy var commentsIconView = IconTextView(text: "25", font: .productSansRegular(size: 15), placeholderIcon: UIImage(systemName: "ellipsis.message"), iconTint: .primaryGreen, iconTextAlignment: .iconLeft, iconSize: 15, textColor: .primaryGrey, textAlignment: .left, contentStackAlignment: .center)
    fileprivate lazy var repostIconView = IconTextView(text: "25", font: .productSansRegular(size: 15), placeholderIcon: UIImage(systemName: "arrow.2.squarepath"), iconTint: .primaryGreen, iconTextAlignment: .iconLeft, iconSize: 15, textColor: .primaryGrey, textAlignment: .left, contentStackAlignment: .center)
    fileprivate lazy var bookmarkIconView = IconTextView(text: "25", font: .productSansRegular(size: 15), placeholderIcon: UIImage(systemName: "bookmark"), iconTint: .primaryGreen, iconTextAlignment: .iconLeft, iconSize: 15, textColor: .primaryGrey, textAlignment: .left, contentStackAlignment: .center)
    fileprivate lazy var shareIconView = IconTextView(text: "25", font: .productSansRegular(size: 15), placeholderIcon: UIImage(systemName: "paperplane"), iconTint: .primaryGreen, iconTextAlignment: .iconLeft, iconSize: 15, textColor: .primaryGrey, textAlignment: .left, contentStackAlignment: .center)
    
    fileprivate lazy var userInfoStackview = HorizontalStackView(arrangedSubviews: [usernameLabel, locationLabel, timestampLabel], distribution: .fillEqually)
    fileprivate lazy var userStatsStackview = HorizontalStackView(arrangedSubviews: [likesIconView, commentsIconView, repostIconView, bookmarkIconView, shareIconView], distribution: .fillEqually)
    fileprivate lazy var userInfoLabelsStackview = VerticalStackView(arrangedSubviews: [nameLabel, userInfoStackview], spacing: 4, distribution: .fill, alignment: .fill)
    fileprivate lazy var userInfoAvatarLabelsStackview = HorizontalStackView(arrangedSubviews: [avatarImageView, userInfoLabelsStackview], spacing: 15, distribution: .fill, alignment: .fill)
    fileprivate let separator = UIView(height: 1, backgroundColor: .primaryGrey)
    
    
    
    fileprivate lazy var containerView = UIView(subviews: [userInfoAvatarLabelsStackview, postLabel, postImage, userStatsStackview, separator])
    
    override func setup() {
        super.setup()
        addSubviews(containerView)
        with(containerView) {
            $0.fillSuperview()
        }
        
        with(userInfoAvatarLabelsStackview) {
            $0.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        }
        
        with(postImage) {
            $0.anchor(top: userInfoAvatarLabelsStackview.bottomAnchor, leading: userInfoAvatarLabelsStackview.leadingAnchor, trailing: userInfoAvatarLabelsStackview.trailingAnchor)
        }
        
        with(userStatsStackview) {
            $0.anchor(top: postImage.bottomAnchor, leading: userInfoAvatarLabelsStackview.leadingAnchor, trailing: userInfoAvatarLabelsStackview.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 3))
        }
        
        with(separator) {
            $0.anchor(top: userStatsStackview.bottomAnchor, leading: userInfoAvatarLabelsStackview.leadingAnchor, bottom: bottomAnchor, trailing: userInfoAvatarLabelsStackview.trailingAnchor, padding: ._init(top: 10, bottom: 0))
        }
    }
    
}
