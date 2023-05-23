//
//  ChatViewController.swift
//  BlinqPay
//
//  Created by ULU on 23/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class ChatListViewController: BaseViewController<ChatListView, IChatViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        title = "Chat"
        navigationController?.tabBarItem.title = nil
    }
    
    override func configureViews() {
        super.configureViews()
        kview.do {
            $0.newMessageButtonTapHandler = { [weak self] in
                self?.startNewMessage()
            }
            
            $0.chatSelectionHandler = { [weak self] in
                self?.show(AppDelegate.dependencyContainer.chatController, sender: self)
            }
        }
    }
    
    private func startNewMessage() {
        let vc = NewChatViewController()
        showDetailViewController(vc, sender: self)
    }

}
