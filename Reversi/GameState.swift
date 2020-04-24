//
//  GameState.swift
//  Reversi
//
//  Created by 秋勇紀 on 2020/04/24.
//  Copyright © 2020 Yuta Koshizawa. All rights reserved.
//

import UIKit

struct GameState {
    var turn: Disk?
    var playerControls: [Int]
    var board: [[Disk?]]
}

extension GameState {
    
    static func builder(turn: Disk?, boardView: BoardView, playerControls: [UISegmentedControl]) -> GameState {
        var state = GameState(playerControls: [], board: [])
        
        state.turn = turn
        state.board = .init(repeating: .init(repeating: nil, count: boardView.height), count: boardView.width)
        state.playerControls = .init(repeating: 0, count: Disk.sides.count)
        
        for side in Disk.sides {
            state.playerControls[side.index] = playerControls[side.index].selectedSegmentIndex
        }
        
        for y in boardView.yRange {
            for x in boardView.xRange {
                state.board[x][y] = boardView.diskAt(x: x, y: y)
            }
        }
        
        return state
    }
}
