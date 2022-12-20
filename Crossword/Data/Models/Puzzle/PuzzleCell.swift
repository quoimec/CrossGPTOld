//
//  PuzzleCell.swift
//  Crossword
//
//  Created by Charlie on 19/12/2022.
//

import Foundation
import CryptoKit

struct CW_PuzzleCell: Identifiable {
    
    var id = UUID()
    
    var index: CW_PuzzleIndex
    var charachter: Character
    var number: String
    var centre: CGPoint
    var rect: CGRect
    var hash: SHA256Digest? = nil
    
}
