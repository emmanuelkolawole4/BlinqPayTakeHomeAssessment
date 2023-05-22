//
//  StackView.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView] = [], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .vertical
        self.distribution = distribution
        self.alignment = alignment
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HorizontalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill, alignment: UIStackView.Alignment = .fill) {
        super.init(frame: .zero)
        arrangedSubviews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .horizontal
        self.distribution = distribution
        self.alignment = alignment
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
