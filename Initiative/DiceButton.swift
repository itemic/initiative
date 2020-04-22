//
//  DiceButton.swift
//  Initiative
//
//  Created by Terran Kroft on 4/21/20.
//  Copyright © 2020 itemic. All rights reserved.
//


import SwiftUI

struct DiceButtonView: View {
    var diceValue: Int // dice value
    
    var color: Color // Color
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Text("d\(diceValue)")
                .fontWeight(.light)
                .font(.body)
                .frame(width: 50, height: 50)
//                .padding()
                .background(Color.white)
            .cornerRadius(15)
                .foregroundColor(.black)
//            .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(color, lineWidth: 2))
            
                
        }
        .frame(minWidth: 40, minHeight: 40)
//        .padding()
//        .overlay(RoundedRectangle(cornerRadius: 15).stroke(color, lineWidth: 4))
//        .foregroundColor(.black)
//        .background(Color.white)
//        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
//        .shadow(color: Color.white.opacity(0.7), radius: 5, x: -0, y: -0)
        
        
        
        
    }
}

struct DiceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DiceButtonView(diceValue: 20, color: .green)
    }
}
