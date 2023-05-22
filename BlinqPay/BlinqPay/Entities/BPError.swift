//
//  BPError.swift
//  BlinqPay
//
//  Created by ULU on 22/05/2023.
//

import Foundation

struct BPError: Codable, Error {
    let code: Int?
    let message, error: String?
}
