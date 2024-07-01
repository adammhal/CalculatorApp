//
//  ContentView.swift
//  Calculator
//
//  Created by Adam Mhal on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Image("bg")
                .resizable()
                .ignoresSafeArea()
            VStack{
                
                HStack{
                    Spacer()
                    RoundedRectangle(cornerRadius: 20).size(CGSize(width: 300.0, height: 100.0)).padding([.top, .leading], 37.0)
                    Spacer()
                }.foregroundColor(.secondary)
                    
            }
        }
    }
}

#Preview {
    ContentView()
}
