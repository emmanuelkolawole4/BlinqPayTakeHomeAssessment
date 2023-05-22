//
//  UIViewController+Utils.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import Foundation
import UIKit
import PopupDialog
import Toast_Swift

extension UIViewController {
    
    func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    func configureNavBar(title: String, barBgColor: UIColor = .primaryGreen, font: UIFont = .productSansBold(size: 16), barTextColor: UIColor = .primaryTextColor, prefersLargeTitle: Bool = false) {
        self.title = title
        navigationController?.navigationBar.apply {
            $0.prefersLargeTitles = prefersLargeTitle
            $0.barTintColor = barBgColor
            $0.titleTextAttributes = [.foregroundColor: barTextColor, .font: font]
            $0.largeTitleTextAttributes = [.foregroundColor: barTextColor, .font: font]
            $0.tintColor = barTextColor
        }
    }
    
    func configureNavBar(centerImage: UIImage? = nil, barTintColor: UIColor = .primaryGreen, tintColor: UIColor = UIColor("#31355B"), height: CGFloat? = nil, width: CGFloat? = nil) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.do {
            $0.barTintColor = barTintColor
            $0.shadowImage = UIImage()
            $0.layoutIfNeeded()
        }
        navigationItem.titleView = UIImageView(image: centerImage, height: height, width: width)
        navigationController?.navigationBar.do {
            $0.tintColor = tintColor
            $0.layer.shadowColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.09).cgColor
            $0.layer.shadowOffset = CGSize(width: 0.0, height: 5)
            $0.layer.shadowRadius = 5.0
            $0.layer.shadowOpacity = 0.5
            $0.layer.masksToBounds = false
        }
    }
    
    func enableSwipeBackToPopGesture(_ enable: Bool = true) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = enable
    }
    
    func showNavigationBarButton(_ status: Bool) {
        if !status {
            navigationItem.rightBarButtonItem?.customView?.alpha = 0.5
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.customView?.alpha = 1
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    var _width: CGFloat { UIScreen.main.bounds.width }
    
    var _height: CGFloat { UIScreen.main.bounds.height }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addSubview(_ view: UIView) {
        self.view.addSubview(view)
    }
    
    var topAnchor: NSLayoutYAxisAnchor? { view.topAnchor }
    
    var bottomAnchor: NSLayoutYAxisAnchor? { view.bottomAnchor }
    
    var leadingAnchor: NSLayoutXAxisAnchor? { view.leadingAnchor }
    
    var trailingAnchor: NSLayoutXAxisAnchor? { view.trailingAnchor }
    
    var safeAreaTopAnchor: NSLayoutYAxisAnchor? { view.safeAreaLayoutGuide.topAnchor }
    
    var safeAreaBottomAnchor: NSLayoutYAxisAnchor? { view.safeAreaLayoutGuide.bottomAnchor }
    
    var safeAreaLeadingAnchor: NSLayoutXAxisAnchor? { view.safeAreaLayoutGuide.leadingAnchor }
    
    var safeAreaTrailingAnchor: NSLayoutXAxisAnchor? { view.safeAreaLayoutGuide.trailingAnchor }
    
    var backgroundColor: UIColor? {
        get { view.backgroundColor }
        set { view.backgroundColor = newValue }
    }
    
    func showNavBar(_ show: Bool = true) {
        navigationController?.navigationBar.isHidden = !show
        navigationController?.setNavigationBarHidden(!show, animated: true)
        navigationController?.isNavigationBarHidden = !show
    }
    
    func setBackButtonText(_ text: String = "") {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: text, style: .plain, target: nil, action: nil)
    }
    
    func showBackButton(_ show: Bool = true) {
        navigationItem.setHidesBackButton(!show, animated: true)
    }
    
    func showTabBar(_ show: Bool = true) {
        tabBarController?.tabBar.isHidden = !show
    }
    
    func _popViewController(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func _popToRootViewController(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func _pushViewController(_ viewcontroller: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewcontroller, animated: animated)
    }
    
    func dismissViewController(animated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = navigationController?.viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            navigationController?.popToViewController(vc, animated: animated)
        }
    }
    
    func setViewControllers(using viewController: UIViewController, animate: Bool = false) {
        navigationController?.setViewControllers([viewController], animated: animate)
    }
    
    func showMessage(_ message: String, type: ToastType = .success) {
        Toast.shared.show(message, type: type)
    }
    
    func showAlert(message: String, type: ToastType = .success, position: ToastPosition = .top, duration: TimeInterval = 3.0, dismissCompletion: (() -> Void)? = nil) {
        hideAlert()
        var color: UIColor = .appGreen
        switch type {
        case .error:
            color = .systemRed
        case .success:
            color = .appGreen
        }
        
        var toastStyle = ToastStyle()
        toastStyle.messageColor = .white
        toastStyle.messageFont = .productSansRegular(size: 14)
        toastStyle.backgroundColor = color
        
        ToastManager.shared.isTapToDismissEnabled = true
        
        runOnMainThread { [weak self] in
            self?.view.makeToast(message, duration: duration, position: position, style: toastStyle)
        }
    }
    
    func hideAlert() {
        runOnMainThread { [weak self] in
            self?.view.hideAllToasts()
        }
    }
    
    func showDialog(for viewController: UIViewController, opacity: CGFloat = 0.1, tapToDismiss: Bool = true, dismissCompletionHandler: (() -> Void)? = nil) {
        let containerAppearance = PopupDialogContainerView.appearance()
        containerAppearance.cornerRadius = Float(10)
        
        let overlayAppearance = PopupDialogOverlayView.appearance()
        overlayAppearance.opacity = opacity
        
        let popupDialog = PopupDialog(viewController: viewController, transitionStyle: .bounceUp, tapGestureDismissal: tapToDismiss, panGestureDismissal: tapToDismiss, completion: dismissCompletionHandler)
        present(popupDialog, animated: true, completion: nil)
    }
    
//    func showResponseViewController(config: ResponseConfig, responseHandler: NoParamHandler? = nil) {
//        setViewControllers(using: ResponseViewController().apply {
//            $0.config = config
//            $0.responseHandler = responseHandler
//        })
//    }
    
    func setBackgroundColor(_ color: UIColor = .aSystemBackground) {
        backgroundColor = color
    }
    
//    func showNavigationMenu(menuItemSelectionHandler: MenuItemParamHandler? = nil, signOutHandler: NoParamHandler? = nil) {
//        let transition = CATransition().apply {
//            $0.duration = 0.5
//            $0.type = .push
//            $0.subtype = .fromLeft
//            $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        }
//        view.window!.layer.add(transition, forKey: kCATransition)
//        present(NavigationMenuViewController().apply {
//            $0.menuItemSelectionHandler = menuItemSelectionHandler
//            $0.signoutHandler = signOutHandler
//            $0.modalPresentationStyle = .overFullScreen
//        }, animated: true)
//    }
    
//    func showFilterableItemsViewController(items: [String], itemName: String, itemSelectionHandler: IntStringParamHandler? = nil) {
//        present(FilterableItemsViewController().apply {
//            $0.items = items
//            $0.itemName = itemName
//            $0.itemSelectionHandler = itemSelectionHandler
//        }, animated: true)
//    }
    
//    func showFilterableItemsViewController_(items: [FilterableItem], itemName: String, itemSelectionHandler: FilterableItemParamHandler? = nil) {
//        present(FilterableItemsViewController_().apply {
//            $0.items = items
//            $0.itemName = itemName
//            $0.itemSelectionHandler = itemSelectionHandler
//        }, animated: true)
//    }
    
    func setStatusBarBackgroundColor(_ backgroundColor: UIColor) {
        navigationController?._setStatusBarBackgroundColor(backgroundColor)
    }
    
//    func showDashboard() {
//        setViewControllers(using: NavigationContainerViewController())
//    }
    
//    func showCarDetailOptionsViewController(titleText: String = .EDIT_CAR, optionSelectionHandler: CarDetailOptionHandler? = nil, delistHandler: StringParamHandler? = nil) {
//        present(CarDetailOptionsViewController().apply {
//            $0.titleText = titleText
//            $0.optionSelectedHandler = optionSelectionHandler
//            $0.delistHandler = delistHandler
//        }, animated: true)
//    }
    
    func showConfirmationDialogViewController(confirmationText: String = Constants.ARE_YOU_SURE_TO_PERFORM_ACTION, yestText: String = Constants.YES, noText: String = Constants.NO, tapToDismiss: Bool = true, noHandler: NoParamHandler? = nil, dismissHandler: NoParamHandler? = nil, yesHandler: NoParamHandler?) {
        showDialog(for: ConfirmationDialogViewController().apply {
            $0.confirmationText = confirmationText
            $0.yesText = yestText
            $0.noText = noText
            $0.noHandler = noHandler
            $0.yesHandler = yesHandler
        }, tapToDismiss: tapToDismiss, dismissCompletionHandler: dismissHandler)
    }
    
//    func showUploadCarDocumentsOptionsViewController() {
//        present(UploadCarDocumentsOptionsViewController().apply {_ in
//            print("showing bottom popup view controller")
//        }, animated: true)
//    }
//
//    func showConfirmationDialogViewController(confirmationText: String = .ARE_YOU_SURE_TO_PERFORM_ACTION, yestText: String = .YES, noText: String = .NO, tapToDismiss: Bool = true, noHandler: NoParamHandler? = nil, dismissHandler: NoParamHandler? = nil, yesHandler: NoParamHandler?) {
//        showDialog(for: ConfirmationDialogViewController().apply {
//            $0.confirmationText = confirmationText
//            $0.yesText = yestText
//            $0.noText = noText
//            $0.noHandler = noHandler
//            $0.yesHandler = yesHandler
//        }, tapToDismiss: tapToDismiss, dismissCompletionHandler: dismissHandler)
//    }
}
    
    extension UINavigationController {
        
        func _setStatusBarBackgroundColor(_ backgroundColor: UIColor) {
            let statusBarFrame: CGRect
            if #available(iOS 13.0, *) {
                statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
            } else {
                statusBarFrame = UIApplication.shared.statusBarFrame
            }
            let statusBarView = UIView(frame: statusBarFrame)
            statusBarView.backgroundColor = backgroundColor
            view.addSubview(statusBarView)
        }
        
    }

