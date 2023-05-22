//
//  HomeView.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import UIKit

@available(iOS 13.0, *)
class HomeView: BaseView {
    
    fileprivate lazy var homeCollectionView = BaseCollectionView(reuseIdentifier: HomeCollectionViewCell.className, cell: HomeCollectionViewCell.self, interitemSpacing: 0, lineSpacing: 20, delegate: self, dataSource: self)
    
    override func setup() {
        super.setup()
        setBackgroundColor(.clear)
        addSubview(homeCollectionView)
        with(homeCollectionView) {
            $0.fillSuperview(padding: ._init(allEdges: 20))
        }
    }

}

@available(iOS 13.0, *)
extension HomeView: UICollectionViewConformable {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.deque(cell: HomeCollectionViewCell.self, at: indexPath).apply {
            $0.backgroundColor = .clear
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentScreenBounds =  UIScreen.main.bounds
        let margins = (left: 20, right: 20)
        let cellWidth = (currentScreenBounds.width - CGFloat((margins.left + margins.right)))
        return CGSize(width: cellWidth, height: 340)
    }
    
}
