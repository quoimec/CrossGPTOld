//
//  Puzzle.swift
//  Crossword
//
//  Created by Charlie on 19/12/2022.
//

import Foundation
import OrderedCollections

struct CW_Puzzle: Identifiable {
    
    var id = UUID()
    
    var size: CW_PuzzleSize
    var grid: OrderedDictionary<CW_PuzzleIndex, CW_PuzzleCell>
    
    init(answers: Array<CW_PuzzleAnswer>, max_width: CGFloat = 200, border: CGFloat = 1) {
        
        var vertical = 0
        var horizontal = 0
        
        for answer in answers {
            vertical = max(vertical, answer.index.vertical + (answer.direction == .down ? answer.word.count : 0))
            horizontal = max(horizontal, answer.index.horizontal + (answer.direction == .across ? answer.word.count : 0))
        }
        
        self.size = CW_PuzzleSize(horizontal: horizontal, vertical: vertical, max_width: max_width, border: border)
        
        self.grid = [:]
        
        for answer in answers {
            
            for (i, letter) in answer.word.enumerated() {
                
                let index = CW_PuzzleIndex(
                    v: answer.index.vertical + (answer.direction == .down ? i : 0),
                    h: answer.index.horizontal + (answer.direction == .across ? i : 0)
                )
                
                if !self.grid.keys.contains(index) {
                    self.grid[index] = CW_PuzzleCell(
                        index: index,
                        charachter: letter,
                        number: i == 0 ? "\(answer.number)" : "",
                        centre: size.cell_centre(index: index),
                        rect: size.cell_rect(index: index)
                    )
                } else if i == 0 {
                    // To-Do: Add checks to throw exceptions here 
                    self.grid[index]!.number = "\(answer.number)"
                }
                
            }
            
        }
        
    }
    
}
