//
//  GameState.swift
//  Reversi
//
//  Created by 秋勇紀 on 2020/04/24.
//  Copyright © 2020 Yuta Koshizawa. All rights reserved.
//

import Foundation

struct GameState {
    var turn: Disk?
    var playerControls: [Int: Int]
    var board: [[Disk?]]
}
