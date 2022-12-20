//
//  CrosswordApp.swift
//  Crossword
//
//  Created by Charlie on 19/12/2022.
//

import SwiftUI

@main
struct CrosswordApp: App {

    var body: some Scene {
        WindowGroup {
            CW_PuzzleView()
                .environmentObject(CW_GameController.shared)
                
        }
    }
}
