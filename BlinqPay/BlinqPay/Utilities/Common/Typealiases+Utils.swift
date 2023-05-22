//
//  Typealiases+Utils.swift
//  BlinqPay
//
//  Created by ULU on 17/05/2023.
//

import Foundation
import UIKit

typealias NoParamHandler = (() -> Void)

typealias StringParamHandler = ((String) -> Void)

typealias DoubleParamHandler = ((Double) -> Void)

typealias IntParamHandler = ((Double) -> Void)

typealias DoubleStringParamHandler = ((String, String) -> Void)

typealias TripleStringParamHandler = ((String, String, String) -> Void)

typealias StringIntParamHandler = ((String, Int) -> Void)

typealias IntStringParamHandler = ((Int, String) -> Void)

//typealias FilterableItemParamHandler = ((FilterableItem) -> Void)

typealias NumericParamHandler = ((any Numeric) -> Void)

typealias ErrorParamHandler = ((Error) -> Void)

typealias UITableViewConformable = UITableViewDelegate & UITableViewDataSource

typealias UICollectionViewConformable = UICollectionViewDelegateFlowLayout & UICollectionViewDelegate & UICollectionViewDataSource

typealias UIImagePickerViewConformable = UIImagePickerControllerDelegate & UINavigationControllerDelegate

typealias StringURLParam = [String : URL]

