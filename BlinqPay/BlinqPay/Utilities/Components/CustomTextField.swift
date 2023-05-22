//
//  CustomTextField.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class CustomTextField: BaseView {

    fileprivate let titleLabel = UILabel(text: "Title Label", font: .productSansRegular(size: 18), numberOfLines: 0, color: .primaryTextColor, alignment: .left)
    fileprivate let errorLabel = UILabel(text: "Error Label", font: .productSansRegular(size: 13), numberOfLines: 0, color: .systemRed, alignment: .left)
    let textField = TextField()
//    fileprivate let passwordIconImageView = UIImageView(image: R.image.eye_open_icon(), tintColor: .primaryTextColor, size: 22)
    fileprivate let pickerManager = PickerManager()
    fileprivate let pickerView = UIPickerView()
    fileprivate var passwordVisible = false
    fileprivate var validationType: ValidationType?
    fileprivate let inputValidator = InputValidatorImpl()
    fileprivate var heightConstraint: NSLayoutConstraint?
    fileprivate var errorLabelHeightConstraint: NSLayoutConstraint?
    fileprivate var errorLabelVisible = false
    fileprivate var maxLength: Int? = nil
    
    var title: String {
        get { titleLabel.text.orEmpty }
        set { titleLabel.text = newValue }
    }
    
    var text: String {
        get { textField.text.orEmpty }
        set { textField.text = newValue }
    }
    
    convenience init(title: String, placeholder: String = "", isPassword: Bool = false, height: CGFloat? = 80, validationType: ValidationType? = nil, keyboardType: UIKeyboardType = .alphabet, maxLength: Int? = nil) {
        self.init(frame: .zero)
        backgroundColor = .clear
        titleLabel.text = title
        with(textField) {
            $0.backgroundColor = UIColor("#DCF6F3").withAlphaComponent(0.7)
            $0.keyboardType = keyboardType
            $0.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font: UIFont.productSansRegular(size: 14), .foregroundColor: UIColor.aPlaceholderText])
            $0.font = .productSansRegular(size: 15)
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        titleLabel.constraintHeight(constant: titleLabel.intrinsicContentSize.height)
        self.validationType = validationType
        self.maxLength = maxLength
        if let height = height {
            heightConstraint = constraintHeight(constant: height)
        }
        
        if isPassword {
            setupPassword()
        }
    }
    
    convenience init(title: String, valueText: String? = nil, placeholder: String = Constants.CHOOSE, height: CGFloat? = 80, items: [String], validationType: ValidationType? = nil, maxLength: Int? = nil, itemSelectionHandler: IntStringParamHandler? = nil) {
        self.init(frame: .zero)
        backgroundColor = .clear
        titleLabel.text = title
        self.validationType = validationType
        self.maxLength = maxLength
        with(textField) {
            $0.backgroundColor = .clear
            $0.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.font: UIFont.productSansRegular(size: 14), .foregroundColor: UIColor.aPlaceholderText])
            $0.font = .productSansRegular(size: 15)
            $0.text = valueText
        }
        titleLabel.constraintHeight(constant: titleLabel.intrinsicContentSize.height)
        if let height = height {
            heightConstraint = constraintHeight(constant: height)
        }
        
        pickerManager.items = items
        pickerManager.selectedItem = { [weak self] index in
            self?.textField.text = items[index]
            itemSelectionHandler?(index, items[index])
        }
        pickerView.delegate = pickerManager
        pickerView.dataSource = pickerManager
        textField.inputView = pickerView
        addDropDownChevron()
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch validationType {
        case .amount:
            textField.text = textField.text?.amountSanitized.double?.currencyFormatted()
        default:
            break
        }
    }
    
    func setupPassword() {
//        let paddingView = UIView(size: 15, backgroundColor: .clear)
//        let passwordIconStackView = HorizontalStackView(arrangedSubviews: [passwordIconImageView, paddingView], alignment: .center)
//        textField.do {
//            $0.padding = ._init(top: 0, left: 15, bottom: 0, right: 45)
//            $0.rightView = passwordIconStackView
//            $0.rightViewMode = .always
//            $0.isSecureTextEntry = true
//            $0.setNeedsLayout()
//            $0.layoutIfNeeded()
//        }
//        passwordIconImageView.animateViewOnTapGesture(duration: 0.1, completion: togglePasswordVisibility)
    }
    
    func togglePasswordVisibility() {
//        if !passwordVisible && text.isNotEmpty {
//            textField.isSecureTextEntry = false
//            passwordVisible = true
//            passwordIconImageView.image = R.image.eye_closed_icon()
//        } else {
//            textField.isSecureTextEntry = true
//            passwordVisible = false
//            passwordIconImageView.image = R.image.eye_open_icon()
//        }
    }
    
    override public func setup() {
        super.setup()
        addSubviews(titleLabel, textField, errorLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        textField.do {
            $0.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: ._init(top: 5))
            $0.constraintHeight(constant: 50)
            $0.viewCornerRadius = 8
            $0.viewBorderWidth = 1
            $0.borderColor = UIColor("#DCF6F3") //.primaryTextColor.withAlphaComponent(0.7)
            $0.clipsToBounds = true
        }
        errorLabel.do {
            $0.anchor(top: textField.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: ._init(top: 4))
            $0.showView(false)
        }
    }
    
    fileprivate func addDropDownChevron() {
        let dropButton = UIButton(type: .system)
        dropButton.frame = CGRect(x: 0, y: 5, width: frame.height, height: frame.height)
//        dropButton.setImage(R.image.arrow_down_icon(), for: .normal)
        dropButton.tintColor = .primaryTextColor
        dropButton.contentEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
        dropButton.addTarget(self, action: #selector(dropdownButtonSelected), for: .touchUpInside)
        textField.rightView =  HorizontalStackView(arrangedSubviews: [dropButton, UIView.hspacer(5)], alignment: .center)
        textField.rightViewMode = .always
    }
    
    @objc fileprivate func dropdownButtonSelected() {
        textField.becomeFirstResponder()
    }
    
    func localizeUI(title: String) {
        titleLabel.text = title
    }
    
    var isValid: Bool {
        if let validationType = validationType {
            let result = inputValidator.validate(text, for: validationType)
            result.isValid ? hideError() : showError(result.message)
            return result.isValid
        }
        return false
    }
    
    func isValidPasswordConfirmation(password: String) -> Bool {
        let result = inputValidator.validateConfirmPassword(password, text)
        result.isValid ? hideError() : showError(result.message)
        return result.isValid
    }
    
    func showError(_ message: String) {
        errorLabel.do {
            $0.text = message
            if !errorLabelVisible {
                errorLabelVisible = true
                errorLabelHeightConstraint = $0.constraintHeight(constant: errorLabel.intrinsicContentSize.height)
                heightConstraint?.constant += errorLabelHeightConstraint!.constant
                _animate(duration: 0.2) { [weak self] in
                    self?.errorLabel.showView()
                    self?.updateTextFieldAppearance(success: false)
                    self?.layoutIfNeeded()
                }
            }
        }
        
    }
    
    func hideError() {
        if errorLabelVisible {
            errorLabelVisible = false
            heightConstraint?.constant -= (errorLabelHeightConstraint?.constant ?? 0)
            errorLabelHeightConstraint?.constant = 0
        }
        _animate(duration: 0.2) { [weak self] in
            self?.errorLabel.showView(false)
            self?.updateTextFieldAppearance()
            self?.layoutIfNeeded()
        }
    }
    
    fileprivate func updateTextFieldAppearance(success: Bool = true) {
        textField.do {
            $0.borderColor = success ? .primaryTextColor.withAlphaComponent(0.7) : .systemRed
            $0.textColor = success ? .primaryTextColor : .systemRed
            if !success {
                $0.shake(duration: 0.2)
            }
        }
    }
    
}

@available(iOS 13.0, *)
extension CustomTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.keyboardType {
        case .decimalPad:
            return textField.restrictInputToDigits(range: range, string: string, allowSpecialCharacterFormatting: true, specialCharacter: ".", maxLength: maxLength)
        default:
            return restrictTextfield(range, string)
        }
    }
    
    fileprivate func restrictTextfield(_ range: NSRange, _ string: String) -> Bool {
        if let maxLength = maxLength {
            if [.numberPad, .phonePad].contains(textField.keyboardType) {
                return textField.restrictToDigitsWithMaximumLength(range: range, string: string, maxLength: maxLength)
            } else {
                return textField.restrictToMaximumLength(range: range, string: string, maxLength: maxLength)
            }
        } else {
            if [.numberPad, .phonePad].contains(textField.keyboardType) {
                return textField.restrictInputToDigits(string: string)
            }
            return true
        }
    }
    
}

class TextField: UITextField {

    var padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}

@available(iOS 13.0, *)
extension Array where Element == CustomTextField {
    var areValid: Bool {
        let isValid = map { $0.isValid }.doesNotContain(false)
        if !isValid {
            first?.textField.becomeFirstResponder()
            generateHapticFeedback()
        }
        return isValid
    }
}
