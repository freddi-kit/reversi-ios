//
//  SaveStatusManager.swift
//  Reversi
//
//  Created by 秋勇紀 on 2020/04/24.
//  Copyright © 2020 Yuta Koshizawa. All rights reserved.
//

import Foundation


class SaveStatusManager {
    
    enum FileIOError: Error {
        case write(path: String, cause: Error?)
        case read(path: String, cause: Error?)
    }
    
    private var path: String {
        (NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first! as NSString).appendingPathComponent("Game")
    }
    
    func loadGame(boardWidth: Int, boardHeight: Int, completion: (Result<GameState, Error>) -> ()) {
        let input: String
        let state: GameState
        var playerControls: [Int: Int] = [:]
        var board: [[Disk?]] = [[]]

        do {
            input = try String(contentsOfFile: path, encoding: .utf8)
        } catch {
            completion(.failure(error))
            return
        }

        var lines: ArraySlice<Substring> = input.split(separator: "\n")[...]

        guard var line = lines.popFirst() else {
            completion(.failure(FileIOError.read(path: path, cause: nil)))
            return
        }

        guard
            let diskSymbol = line.popFirst(),
            let turn = Optional<Disk>(symbol: diskSymbol.description)
        else {
            completion(.failure(FileIOError.read(path: path, cause: nil)))
            return
        }

        // players
        for side in Disk.sides {
            guard
                let playerSymbol = line.popFirst(),
                let playerNumber = Int(playerSymbol.description),
                let player = ViewController.Player(rawValue: playerNumber)
            else {
                completion(.failure(FileIOError.read(path: path, cause: nil)))
                return
            }
            playerControls[side.index] = player.rawValue
        }

        guard lines.count == boardHeight else {
            completion(.failure(FileIOError.read(path: path, cause: nil)))
            return
        }
        
        board = [[Disk?]](repeating: [Disk?](repeating: nil, count: boardWidth), count: boardHeight)
        
        var y = 0
        while let line = lines.popFirst() {
            var x = 0
            for character in line {
                let disk = Disk?(symbol: "\(character)").flatMap { $0 }
                board[x][y] = disk
                x += 1
            }
            guard x == boardWidth else {
                completion(.failure(FileIOError.read(path: path, cause: nil)))
                return
            }
            y += 1
        }
        
        guard y == boardHeight else {
            completion(.failure(FileIOError.read(path: path, cause: nil)))
            return
        }
        
        state = GameState(turn: turn, playerControls: playerControls, board: board)
        completion(.success(state))
    }
}
