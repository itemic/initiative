//
//  DiceShaep.swift
//  Initiative
//
//  Created by Terran Kroft on 4/22/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import SwiftUI

struct DiceShape: View {
    var body: some View {
        Text("12")
            .fontWeight(.semibold)
            .font(.system(.caption, design: .rounded))
            .frame(width: 30, height: 30)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
            
        
        
    }
}

struct DiceShape_Previews: PreviewProvider {
    static var previews: some View {
        DiceShape()
    }
}
