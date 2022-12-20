//
//  PuzzleSize.swift
//  Crossword
//
//  Created by Charlie on 19/12/2022.
//

import Foundation

struct CW_PuzzleSize {
    
    var vertical: Int
    var horizontal: Int
    
    var square: CGFloat
    var width: CGFloat
    var height: CGFloat
    var border: CGFloat
    
    init(horizontal: Int, vertical: Int, max_width: CGFloat, border: CGFloat) {
        
        self.horizontal = horizontal
        self.vertical = vertical
        
        self.square = floor((max_width - (border * 4)) / CGFloat(horizontal))
        self.width = CGFloat(border * 4) + (square * CGFloat(horizontal))
        self.height = CGFloat(border * 4) + (square * CGFloat(vertical))
        self.border = border
        
    }
    
    func cell_centre(index: CW_PuzzleIndex) -> CGPoint {
        
        return CGPoint(
            x: (CGFloat(index.horizontal) * square) + (square / 2),
            y: (CGFloat(index.vertical) * square) + (square / 2)
        )
        
    }
    
    func cell_rect(index: CW_PuzzleIndex) -> CGRect {
        
        return CGRect(
            x: CGFloat(index.horizontal) * square,
            y: CGFloat(index.vertical) * square,
            width: square,
            height: square
        )
        
    }
    
}
