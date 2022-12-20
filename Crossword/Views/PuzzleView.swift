//
//  PuzzleView.swift
//  Crossword
//
//  Created by Charlie on 19/12/2022.
//

import SwiftUI
import SchacherKit
import PencilKit

struct CW_PuzzleView: View {
    
    @EnvironmentObject var game: CW_GameController
    
    var canvas = PKCanvasView()
    
    @State var img: UIImage?
    
    var body: some View {
        
        VStack(content: {
        
            ZStack(content: {
                            
                ZStack(content: {
                    
                    ForEach(game.puzzle.grid.values, content: { cell in
                        
                        ZStack(content: {
                            
                            Rectangle()
                                .fill(Colour.white)
                                .border(.black, width: game.puzzle.size.border / 2)
                                .frame(width: game.puzzle.size.square, height: game.puzzle.size.square)
                            
                            Text(cell.number)
                                .frame(width: game.puzzle.size.square - 14, height: game.puzzle.size.square - 14, alignment: .topLeading)
                            
                            Text(String(cell.charachter))
                            
                        })
                            .position(cell.centre)
                        
                    })
                    
                })
                .frame(width: game.puzzle.size.square * CGFloat(game.puzzle.size.horizontal), height: game.puzzle.size.square * CGFloat(game.puzzle.size.vertical))
                .cornerRadius(10)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.red, lineWidth: game.puzzle.size.border)
                })
                
                MyCanvas(canvasView: canvas)
                    .frame(width: game.puzzle.size.square * CGFloat(game.puzzle.size.horizontal), height: game.puzzle.size.square * CGFloat(game.puzzle.size.vertical))
                    .cornerRadius(10)
                
                Path({ path in

                    for h in (0 ... game.puzzle.size.horizontal) {

                        let x = (CGFloat(h) * game.puzzle.size.square) + (game.puzzle.size.border * 2)

                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: game.puzzle.size.height))

                    }

                    for v in (0 ... game.puzzle.size.vertical) {

                        let y = (CGFloat(v) * game.puzzle.size.square) + (game.puzzle.size.border * 2)

                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: game.puzzle.size.width, y: y))

                    }

                })
                .stroke(Colour.red, lineWidth: game.puzzle.size.border)
                .allowsHitTesting(false)
                
                Path({ path in

                    // Outer square
                    path.addLines([
                        CGPoint(x: 0 + game.puzzle.size.border, y: 0 + game.puzzle.size.border),
                        CGPoint(x: game.puzzle.size.width - game.puzzle.size.border, y: 0 + game.puzzle.size.border),
                        CGPoint(x: game.puzzle.size.width - game.puzzle.size.border, y: game.puzzle.size.height - game.puzzle.size.border),
                        CGPoint(x: 0 + game.puzzle.size.border, y: game.puzzle.size.height - game.puzzle.size.border)
                    ])
                    path.closeSubpath()

                })
                .stroke(Colour.red, lineWidth: game.puzzle.size.border * 2)
                
            })
            .frame(width: game.puzzle.size.width, height: game.puzzle.size.height)
            .background(Colour.black)
            .cornerRadius(16)
            
            if img != nil {
                
                Image(uiImage: img!)
                    .background(.green)
                
            }
            
            Button("poop", action: {
                
                game.classify(drawing: canvas.drawing)
//                    .applyingFilter("CIColorControls", parameters: [kCIInputSaturationKey: 0.0])
                img = UIImage(ciImage: CIImage(data: canvas.drawing.image(from: CGRect(x: 0, y: 0, width: game.puzzle.size.square, height: game.puzzle.size.square), scale: 1.0).jpegData(compressionQuality: 1.0)!)!)
                
                
                
//                UIImage(ciImage: CIImage(image: !.applyingFilter("CIColorMatrix", parameters: [""]))
                
                
//                img = UIImage(data: canvas.drawing.image(from: CGRect(x: 0, y: 0, width: game.puzzle.size.square, height: game.puzzle.size.square), scale: 1.0).ciImage!  .jpegData(compressionQuality: 1.0)!)
                
            })
            
            
        })
        
    }
    
}

struct MyCanvas: UIViewRepresentable {
    var canvasView: PKCanvasView
    let picker = PKToolPicker.init()
    
    func makeUIView(context: Context) -> PKCanvasView {
        self.canvasView.tool = PKInkingTool(.pen, color: .blue, width: 15)
        self.canvasView.becomeFirstResponder()
        self.canvasView.backgroundColor = UIColor.clear
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        picker.addObserver(canvasView)
        picker.setVisible(true, forFirstResponder: uiView)
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
    }
    
}


//struct CW_PuzzleView_Previews: PreviewProvider {
//
//    static var puzzle = CW_Puzzle(answers: [
//        CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 0, h: 0), word: "HELLO", number: 1, clue: "A typical greeting", direction: .across),
//        CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 1, h: 0), word: "AZEEZ", number: 7, clue: "Yo mama", direction: .across),
//        CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 2, h: 0), word: "BIMBO", number: 2, clue: "Yo mama", direction: .across),
//        CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 4, h: 0), word: "TRACE", number: 3, clue: "To outline, draw", direction: .across),
//        CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 0, h: 0), word: "HABIT", number: 1, clue: "Weed does not form this", direction: .down),
//        CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 0, h: 2), word: "LEMMA", number: 4, clue: "A theorem", direction: .down),
//        CW_PuzzleAnswer(index: CW_PuzzleIndex(v: 0, h: 4), word: "OZONE", number: 5, clue: "Like onions", direction: .down)
//    ], max_width: 500, border: 3)
//
//    static var previews: some View {
//        CW_PuzzleView(puzzle: puzzle)
//    }
//}
