//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Adam Mhal on 6/29/24.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func add(x1: Int, x2: Int) -> Int{
        return x1 + x2
    }
}
