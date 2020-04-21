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
    var color: Color = .blue
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Text("d\(diceValue)")
                .fontWeight(.light)
                
                .font(.title)
                
        }
        .frame(minWidth: 100, minHeight: 100)
        .foregroundColor(.white)
        .background(color)
        .cornerRadius(45)
        
        
        
        
    }
}

struct DiceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DiceButtonView(diceValue: 20)
    }
}
