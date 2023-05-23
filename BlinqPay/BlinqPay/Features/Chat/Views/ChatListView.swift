//
//  ChatView.swift
//  BlinqPay
//
//  Created by ULU on 23/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class ChatListView: BaseView {
    
    var newMessageButtonTapHandler: (() -> Void)?
    var chatSelectionHandler: (() -> Void)?
    
    fileprivate lazy var chatsTableView = UITableView(cell: ChatTableViewCell.self, delegate: self, datasource: self)
    fileprivate lazy var newMessageButton = CustomButton(font: .productSansBold(), backgroundColor: .primaryGreen, textColor: .white, cornerRadius: 25, height: 50, width: 50, image: UIImage(systemName: "plus"), tintColor: .white, tapAction: newMessageButtonTapped)

    
    override func setup() {
        super.setup()
        setBackgroundColor(.clear)
        addSubviews(chatsTableView, newMessageButton)
        with(chatsTableView) {
            $0.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: ._init(allEdges: 20))
        }
        
        with(newMessageButton) {
            $0.anchor(top: chatsTableView.bottomAnchor, bottom: bottomAnchor, trailing: chatsTableView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 30, right: 0))
        }
    }
    
    fileprivate func newMessageButtonTapped() {
        newMessageButtonTapHandler?()
    }

}

@available(iOS 13.0, *)
extension ChatListView: UITableViewConformable {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.deque(cell: ChatTableViewCell.self, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        chatSelectionHandler?()
    }
}
