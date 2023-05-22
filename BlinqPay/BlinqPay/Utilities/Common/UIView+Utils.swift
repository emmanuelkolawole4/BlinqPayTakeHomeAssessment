//
//  UIView+Utils.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

//MARK: - Custom UIViewTapGestureRecognizer
public class UIViewTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}

extension UIView {
    
    static func spacer(_ height: CGFloat = 10) -> UIView {
        UIView(height: height, backgroundColor: .clear)
    }
    
    static func hspacer(_ width: CGFloat = 10) -> UIView {
        UIView(width: width, backgroundColor: .clear)
    }
    
    static func separatorLine(_ color: UIColor = .aSeparator) -> UIView {
        UIView(height: 1, backgroundColor: color)
    }
    
    convenience init(subviews: [UIView]? = nil, height: CGFloat? = nil, width: CGFloat? = nil, size: CGFloat? = nil, backgroundColor: UIColor? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil, radius: CGFloat? = nil) {
        self.init()
        if let subviews = subviews {
            addSubviews(subviews)
        }
        if let height = height {
            constraintHeight(constant: height)
        }
        if let width = width {
            constraintWidth(constant: width)
        }
        if let size = size {
            constraintSize(constant: size)
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let radius = radius {
            viewCornerRadius = radius
        }
        if let borderWidth = borderWidth {
            viewBorderWidth = borderWidth
        }
        if let borderColor = borderColor {
            self.borderColor = borderColor
        }
    }
    
    var id: String? {
        get { accessibilityIdentifier }
        set { accessibilityIdentifier = newValue }
    }
    
    func addRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func addTapGesture(action: @escaping () -> Void ){
        let tap = UIViewTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: UIViewTapGestureRecognizer) {
        sender.action!()
    }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
    
    func addDropShadow(color: UIColor = .darkGray, opacity: Float = 0.5, offSet: CGSize = CGSize(width: -1, height: 1), radius: CGFloat = 5, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addCornerRadius(radius: CGFloat = 5, maskToBounds: Bool = true) {
        layer.cornerRadius = radius
        layer.masksToBounds = maskToBounds
    }
    
    func animateOnClick(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.5
        }) { completed in
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 1
                completion?()
            })
        }
    }
    
    func showView(_ show: Bool = true) {
        isHidden = !show
    }
    
    func animateView(duration: TimeInterval = 0.5, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.5
        }) { completed in
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1
                completion?()
            })
        }
    }
    
    func animateViewOnTapGesture(duration: TimeInterval = 0.2, completion: (() -> Void)? = nil) {
        addTapGesture {
            self.animateView(duration: duration, completion: completion)
        }
    }
    
    func enableUserInteraction(_ enable: Bool = true) {
        isUserInteractionEnabled = enable
    }
    
    var width: CGFloat { frame.size.width }
    
    var height: CGFloat { frame.size.height }
    
    var minY: CGFloat { frame.minY }
    
    var maxY: CGFloat { frame.maxY }
    
    var minX: CGFloat { frame.minX }
    
    var maxX: CGFloat { frame.maxX }
    
    var x: CGFloat {
        get { frame.origin.x }
        set { frame.origin.x = newValue }
    }
    
    var y: CGFloat {
        get { frame.origin.y }
        set { frame.origin.y = newValue }
    }
    
    func addClearBackground() {
        backgroundColor = .clear
    }
    
    func applyShadow(radius:CGFloat = 5){
        layer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.09).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = radius
        layer.shadowOffset = .init(width: 0, height: radius)
        
    }
    
    func applyShadowWith(radius: CGFloat) {
        var shadowLayer: CAShapeLayer!

        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
            shadowLayer.fillColor = UIColor.clear.cgColor
            shadowLayer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.09).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = .init(width: 0, height: 10)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 5
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
    
    func setBackgroundColor(_ color: UIColor) {
        backgroundColor = color
    }
    
    func bringToFront(_ views: UIView...) {
        views.forEach { bringSubviewToFront($0) }
    }
    
    func faded(_ fade: Bool = true, alpha: CGFloat = 0.7) {
        self.alpha = fade ? alpha : 1
    }
}

extension Array where Element == UIView {
    func addClearBackground() {
        forEach { $0.addClearBackground() }
    }
    
    func showViews(_ show: Bool = true) {
        forEach { $0.showView(show) }
    }
    
    func enableUserInteraction(_ enable: Bool = true) {
        forEach { $0.enableUserInteraction(enable) }
    }
    
    func addRoundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        forEach { $0.addRoundCorners(corners, radius: radius) }
    }
    
    func faded(_ fade: Bool = true, alpha: CGFloat = 0.7) {
        forEach { $0.faded(fade, alpha: alpha) }
    }
}

// MARK: - UICollectionView Extensions
extension UICollectionView {

    func setEmptyMessage(_ message: String = Constants.DATA_NOT_FOUND) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .aLabel
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .productSansRegular(size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func restore() {
        self.backgroundView = nil
    }
    
    func deque<T: UICollectionViewCell>(cell: T.Type, at indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: cell.className, for: indexPath) as! T
    }
}

// MARK: - UITableView Extensions
extension UITableView {
    
    convenience init(cell: UITableViewCell.Type, reuseId: String = "", showIndicators: Bool = false, delegate: UITableViewDelegate? = nil, datasource: UITableViewDataSource? = nil, separatorStyle: UITableViewCell.SeparatorStyle = .none, separatorColor: UIColor = .clear, scrollable: Bool = true) {
        self.init()
        self.showIndicators(showIndicators)
        if let delegate = delegate {
            self.delegate = delegate
        }
        if let datasource = datasource {
            self.dataSource = datasource
        }
        self.separatorStyle = separatorStyle
        self.separatorColor = separatorColor
        register(cell.self, forCellReuseIdentifier: cell.className)
        isScrollEnabled = scrollable
    }

    func setEmptyMessage(_ message: String = Constants.DATA_NOT_FOUND, separatorStyle: UITableViewCell.SeparatorStyle = .none) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .aLabel
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .productSansRegular(size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.isScrollEnabled = false
        self.separatorStyle = separatorStyle
    }

    func restore(separatorStyle: UITableViewCell.SeparatorStyle = .none) {
        self.backgroundView = nil
        self.isScrollEnabled = true
        self.separatorStyle = separatorStyle
    }
    
    func deque<T: UITableViewCell>(cell: T.Type, at indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: cell.className, for: indexPath) as! T
    }
    
    func scrollable(_ scrollable: Bool = true) {
        isScrollEnabled = scrollable
    }
}

extension Array where Element == UITableView {
    func scrollable(_ scrollable: Bool = true) {
        forEach { $0.scrollable(scrollable) }
    }
}

extension Reactive where Base: UITableView {
    func isEmpty(message: String = Constants.DATA_NOT_FOUND) -> Binder<Bool> {
        return Binder(base) { tableView, isEmpty in
            if isEmpty {
                tableView.setEmptyMessage(message)
            } else {
                tableView.restore()
            }
        }
    }
}

extension Reactive where Base: UICollectionView {
    func isEmpty(message: String = Constants.DATA_NOT_FOUND) -> Binder<Bool> {
        return Binder(base) { collectionView, isEmpty in
            if isEmpty {
                collectionView.setEmptyMessage(message)
            } else {
                collectionView.restore()
            }
        }
    }
}

extension UIImageView {
    func setImageFromURL(url: String, placeholderImage: UIImage? = nil) {
        sd_setImage(with: URL(string: url), placeholderImage: placeholderImage)
    }
    
    func setImageColor(_ color: UIColor) {
      let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
      self.image = templateImage
      self.tintColor = color
    }
      
    convenience init(subviews: [UIView]? = nil, image: UIImage? = nil, contentMode: UIView.ContentMode = .scaleAspectFit, tintColor: UIColor? = nil, size: CGFloat? = nil, height: CGFloat? = nil, width: CGFloat? = nil, cornerRadius: CGFloat? = nil, backgroundColor: UIColor? = nil) {
        self.init(image: image)
        if let subviews = subviews {
            addSubviews(subviews)
        }
        if let tintColor = tintColor {
            self.tintColor = tintColor
        }
        self.contentMode = contentMode
        if let size = size {
            constraintSize(constant: size)
        }
        if let height = height {
            constraintHeight(constant: height)
        }
        if let width = width {
            constraintWidth(constant: width)
        }
        if let cornerRadius = cornerRadius {
            viewCornerRadius = cornerRadius
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
}

extension UIImage {
    
    static func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    func withTint(_ color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
    
    func withColor(_ color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    func withSize(_ newSize: CGSize) -> UIImage {
        
        let widthRatio  = newSize.width  / size.width
        let heightRatio = newSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

//MARK: - UIButton Extensions
extension UIButton {
    
    var title: String? {
        get { title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    var attributedTitle: NSAttributedString? {
        get { attributedTitle(for: .normal) }
        set { setAttributedTitle(newValue, for: .normal) }
    }
    
    var textColor: UIColor? {
        get { self.titleColor(for: .normal) }
        set { self.setTitleColor(newValue, for: .normal) }
    }
    
    func enable(_ enable: Bool = true) {
        enableUserInteraction(enable)
        alpha = enable ? 1 : 0.7
    }
    
    var font: UIFont? {
        get { titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
    
    func adjustsFontSizeToFitWidth() {
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
    }
    
    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }
}

extension UISearchBar {
    
    convenience init(placeholder: String = "Search", font: UIFont = .productSansRegular(size: 15), showsCancelButton: Bool = true, searchBarStyle: UISearchBar.Style = .minimal, height: CGFloat? = nil, delegate: UISearchBarDelegate? = nil) {
        self.init(frame: .zero)
        self.font = font
        self.showsCancelButton = showsCancelButton
        self.searchBarStyle = searchBarStyle
        self.placeholder = placeholder
        self.delegate = delegate
        if let height = height {
            textField?.constraintHeight(constant: height)
        }
    }
    
    func updateAppearance(height: CGFloat, radius: CGFloat = 8.0, backgroundColor: UIColor = .aSecondarySystemBackground, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) {
        let image: UIImage? = UIImage.imageWithColor(color: backgroundColor, size: CGSize(width: 1, height: height))
        setSearchFieldBackgroundImage(image, for: .normal)
        for subview in self.subviews {
            for subSubViews in subview.subviews {
                if #available(iOS 13.0, *) {
                    for child in subSubViews.subviews {
                        if let textField = child as? UISearchTextField {
                            updateTextFieldAppearance(textField)
                        }
                    }
                    continue
                }
                if let textField = subSubViews as? UITextField {
                    updateTextFieldAppearance(textField)
                }
            }
        }
        
        func updateTextFieldAppearance(_ textfield: UIView) {
            with(textfield) {
                $0.layer.cornerRadius = radius
                $0.clipsToBounds = true
                if let borderColor = borderColor {
                    $0.borderColor = borderColor
                }
                if let borderWidth = borderWidth {
                    $0.viewBorderWidth = borderWidth
                }
            }
        }
    }
    
    var textField : UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            for view : UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
    
    var font: UIFont? {
        get { textField?.font }
        set { textField?.font = newValue }
    }
}

extension UILabel {
    
    convenience init(text: String, font: UIFont = .productSansRegular(size: 16), numberOfLines: Int = 1, color: UIColor = .aLabel, alignment: NSTextAlignment = .center, adjustsFontSizeToFitWidth: Bool = true, underlined: Bool = false, huggingPriority: UILayoutPriority? = nil, huggingAxis: NSLayoutConstraint.Axis? = nil) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = color
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        if underlined {
            underline()
        }
        if let huggingPriority = huggingPriority, let huggingAxis = huggingAxis {
            setContentHuggingPriority(huggingPriority, for: huggingAxis)
        }
    }
    
    convenience init(attributedText: NSAttributedString, numberOfLines: Int = 1, alignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        self.attributedText = attributedText
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
    }
    
    func setLineHeight(spacing: CGFloat) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
    
    func cross() {
        let attr: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
        attr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attr.length))
        attributedText = attr
    }
    
    func underline() {
        let attr: NSMutableAttributedString =  NSMutableAttributedString(string: self.text ?? "")
        attr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attr.length))
        attributedText = attr
        
    }
    
    func setText(_ text:String) {
        self.text = text
    }
}

extension UITextField {
    
    func restrictInputToDigits(string: String, allowCurrencyFormatting: Bool = false, currencySymbol: String = "") -> Bool {
        // remove non-numerics and compare with original string
        let currencyExtras = allowCurrencyFormatting ? ",\(currencySymbol)" : ""
        return string == string.filter("\(currencyExtras)0123456789".contains)
    }
    
    func restrictInputToDigits(range: NSRange, string: String, allowSpecialCharacterFormatting: Bool = false, specialCharacter: String = "", maxLength: Int? = nil) -> Bool {
        
        if let maxLength = maxLength {
            // get the current text, or use an empty string if the failed
            let currentText = text ?? ""
            
            // attempt to read the range they are trying to change, or exit if we can't
            guard let stringRange = Range(range, in: currentText) else { return false }
            
            // add their new text to the existing text
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            //  make sure the result is under `maxLength` characters and remove non-numerics and compare with original string
            return string == string.filter("\(specialCharacter)0123456789".contains) && updatedText.count <= maxLength
        }
        
        return string == string.filter("\(specialCharacter)0123456789".contains)
    }
    
    func restrictToDigitsWithMaximumLength(range: NSRange, string: String, maxLength: Int) -> Bool {
        // get the current text, or use an empty string if the failed
        let currentText = text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        //  make sure the result is under `maxLength` characters and remove non-numerics and compare with original string
        return string == string.filter("0123456789".contains) && updatedText.count <= maxLength
        
    }
    
    func restrictToMaximumLength(range: NSRange, string: String, maxLength: Int) -> Bool {
        // get the current text, or use an empty string if the failed
        let currentText = text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        //  make sure the result is under `maxLength` characters and remove non-numerics and compare with original string
        return updatedText.count <= maxLength
        
    }
    
    func setPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let left = left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: frame.size.height))
            leftViewMode = .always
        }
        if let right = right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: right, height: self.frame.size.height))
            rightViewMode = .always
        }
    }
}

extension UITextView {
    func restrictToMaximumLength(range: NSRange, string: String, maxLength: Int) -> Bool {
        // get the current text, or use an empty string if the failed
        let currentText = text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        //  make sure the result is under `maxLength` characters and remove non-numerics and compare with original string
        return updatedText.count <= maxLength
        
    }
}

extension UIScrollView {
    
    convenience init(children: [UIView], showsVerticalScrollIndicator: Bool = false, showsHorizontalScrollIndicator: Bool = false) {
        self.init(frame: .zero)
        addSubviews(children)
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
    }
    
    func updateContentView(_ offset: CGFloat = 50) {
        contentSize.height = (subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height) + offset
    }
    
    func showIndicators(_ show: Bool = true) {
        showsVerticalScrollIndicator = show
        showsHorizontalScrollIndicator = show
    }
    
    var _topAnchor: NSLayoutYAxisAnchor? { contentLayoutGuide.topAnchor }
    
    var _bottomAnchor: NSLayoutYAxisAnchor? { contentLayoutGuide.bottomAnchor }
    
    var _leadingAnchor: NSLayoutXAxisAnchor? { frameLayoutGuide.leadingAnchor }
    
    var _trailingAnchor: NSLayoutXAxisAnchor? { frameLayoutGuide.trailingAnchor }
}

extension UIPageControl {
    convenience init(indicatorColor: UIColor, currentPageColor: UIColor, numberOfItems: Int = 1, transformBy scale: CGFloat = 1.5) {
        self.init()
        pageIndicatorTintColor = indicatorColor
        currentPageIndicatorTintColor = currentPageColor
        numberOfPages = numberOfItems
        transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}

extension UICollectionView {
    func scrollToNearestVisibleCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension UIProgressView {
    convenience init(style: UIProgressView.Style = .bar, value: Float? = nil, progressTintColor: UIColor = .primaryTextColor, trackTintColor: UIColor = .aSecondaryLabel.withAlphaComponent(0.4), height: CGFloat? = nil, width: CGFloat? = nil) {
        self.init()
        progressViewStyle = .bar
        if let value = value {
            progress = value
        }
        self.progressTintColor = progressTintColor
        self.trackTintColor = trackTintColor
        if let height = height {
            constraintHeight(constant: height)
        }
        if let width = width {
            constraintWidth(constant: width)
        }
    }
}

