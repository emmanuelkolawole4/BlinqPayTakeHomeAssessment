//
//  DashboardViewModelImpl.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class DashboardViewModelImpl: BaseViewModel, IDashboardViewModel {
    
    private var preference: IPreference
//    private let auctionRemote: IAuctionRemoteDatasource
    
    init(preference: IPreference
//         auctionRemote: IAuctionRemoteDatasource,
    ) {
        self.preference = preference
//        self.auctionRemote = auctionRemote
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
}

