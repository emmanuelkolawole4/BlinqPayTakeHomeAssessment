//
//  ConfirmationDialogViewController.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import UIKit

final class ConfirmationDialogViewController: UIViewController {
    
    var yesHandler: NoParamHandler?
    var noHandler: NoParamHandler?
    var noText: String = Constants.NO
    var yesText: String = Constants.YES
    var confirmationText: String = ""
    
    fileprivate lazy var noButton: CustomButton = {
        CustomButton(title: noText, backgroundColor: .clear, borderWidth: 1, borderColor: .primaryGreen, height: 50, tapAction: handleNoButtonTapped)
    }()
    
    fileprivate lazy var yesButton: CustomButton = {
        CustomButton(title: yesText, height: 50, tapAction: handleYesButtonTapped)
    }()
    
    fileprivate lazy var buttonsStackView: HorizontalStackView = {
        HorizontalStackView(arrangedSubviews: [noButton, yesButton], spacing: 20, distribution: .fillEqually)
    }()
    
    fileprivate lazy var contentStackView: VerticalStackView = {
        VerticalStackView(arrangedSubviews: [textLabel, buttonsStackView], spacing: 20)
    }()
    
    fileprivate lazy var textLabel: UILabel = {
        UILabel(text: confirmationText, font: .productSansBold(size: 16), numberOfLines: 0, color: .primaryTextColor, alignment: .center)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    fileprivate func setupUI() {
        addSubview(contentStackView)
        contentStackView.fillSuperview(padding: ._init(allEdges: 20))
    }
    
    fileprivate func handleNoButtonTapped() {
        dismissViewController { [weak self] in
            self?.noHandler?()
        }
    }
    
    fileprivate func handleYesButtonTapped() {
        dismissViewController { [weak self] in
            self?.yesHandler?()
        }
    }

}
