//
//  Optional+Extenstion.swift
//  Reversi
//
//  Created by 秋勇紀 on 2020/04/24.
//  Copyright © 2020 Yuta Koshizawa. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Disk {
    init?<S: StringProtocol>(symbol: S) {
        switch symbol {
        case "x":
            self = .some(.dark)
        case "o":
            self = .some(.light)
        case "-":
            self = .none
        default:
            return nil
        }
    }
    
    var symbol: String {
        switch self {
        case .some(.dark):
            return "x"
        case .some(.light):
            return "o"
        case .none:
            return "-"
        }
    }
}

