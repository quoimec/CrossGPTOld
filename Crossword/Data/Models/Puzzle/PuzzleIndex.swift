//
//  PuzzleIndex.swift
//  Crossword
//
//  Created by Charlie on 19/12/2022.
//

import Foundation

struct CW_PuzzleIndex: Hashable, Identifiable {
    
    var id: String
    
    var vertical: Int
    var horizontal: Int
    
    init(v: Int, h: Int) {
        self.id = "\(v)|\(h)"
        self.vertical = v
        self.horizontal = h
    }
    
}
