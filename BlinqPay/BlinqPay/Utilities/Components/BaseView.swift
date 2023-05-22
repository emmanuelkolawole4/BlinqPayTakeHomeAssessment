//
//  BaseView.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import UIKit
import RxSwift

@available(iOS 13.0, *)
open class BaseView: UIView {
    
    let disposeBag = DisposeBag()
    var preference = PreferenceImpl()
    var viewMessage = PublishSubject<AlertMessage>()

    open func setup() {
        backgroundColor = .systemBackground
    }
    
    open func layout() {}
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
