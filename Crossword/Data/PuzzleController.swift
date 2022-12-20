//
//  PuzzleController.swift
//  Crossword
//
//  Created by Charlie on 19/12/2022.
//

import Foundation
import CoreML
import PencilKit
import CryptoKit

extension UnsignedInteger where Self: CVarArg {
    var hexa: String { .init(format: "%ll*0x", bitWidth / 4, self) }
}

class CW_GameController: ObservableObject {
    
    static let shared = CW_GameController()
    
    var puzzle: CW_Puzzle
    
    init() {
        
        self.puzzle = CW_Puzzle(answers: [
            CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 0, h: 0), word: "HELLO", number: 1, clue: "A typical greeting", direction: .across),
            CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 2, h: 0), word: "BIMBO", number: 2, clue: "Yo mama", direction: .across),
            CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 4, h: 0), word: "TRACE", number: 3, clue: "To outline, draw", direction: .across),
            CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 0, h: 0), word: "HABIT", number: 1, clue: "Weed does not form this", direction: .down),
            CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 0, h: 4), word: "OZONE", number: 5, clue: "Like onions", direction: .down)
        ], max_width: 500, border: 3)
        
    }
    
    func classify(drawing: PKDrawing) {
        
        for cell in puzzle.grid.values {
            
            var hash = Data(SHA256.hash(data: drawing.image(from: cell.rect, scale: 1.0).pngData()!)).map(\.hexa).joined()
            
            let empty = "0604e1227f174cd97a18214e56d4b67064f8472239c9ef104f27b6db466b860a"
            
            print(hash == empty)
            
            print(hash)
            
            
        }
        
        
//        canvas.drawing.image(from: CGRect(x: 0, y: 0, width: puzzle.size.square, height: puzzle.size.square), scale: 1.0)
        
    }
    
}
