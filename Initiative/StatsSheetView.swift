//
//  StatsSheetView.swift
//  Initiative
//
//  Created by Terran Kroft on 4/22/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import SwiftUI

struct StatsSheetView: View {
    var diceMap: [Int:Int]
    
    // TODO SUPPORT OFFSETS
    var probDist: [Int: Double] {
        
        var dist = [Int:Double]()
        
        for i in rangeMin...rangeMax {
            dist[i] = 0 // just initialize range
        }
        
        
        
        return dist
    }
    
    var rangeMin: Int {
        var sum = 0
        for k in diceMap.keys {
            sum += diceMap[k]!
        }
        return sum
    }
    
    var rangeMax: Int {
        var sum = 0
        for k in diceMap.keys {
            sum += k * diceMap[k]!
        }
        return sum
    }
    
    var diceCount: Int {
        return diceMap.values.reduce(0, +)
    }
    
    var uniqueDiceValue: Int? {
        
        let filtered = diceMap.filter {$0.value != 0}
        
        let filteredSize = filtered.keys.count
        
        if filteredSize == 1 {
            return Array(filtered.keys)[0]
        } else {
            return nil
        }
    }
    
    var uniqueDice: Bool {
        if uniqueDiceValue != nil {
            return true
        } else {
            return false
        }
    }
    
    var mostFrequent: Int {
        if uniqueDiceValue == nil {
            return 0
        } else {
            let s = uniqueDiceValue!
            let n = diceMap[s]!
            return Int(floor(0.5 * Double(n) * (Double(s) + 1.0)))
        }
        
    }
    
    
    
    var stateSpace: Int {
        var val = 1
        let sum = diceMap.values.reduce(0, +)
        if sum == 0 {
            return 0
        }
        for k in diceMap.keys {
            val *= Int(pow(Double(k), Double(diceMap[k]!)))
        }
        return val
    }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Statistics")) {
                    HStack{
                        Text("Number of dice")
                        Spacer()
                        Text("\(diceCount)")
                    }
                    HStack{
                        Text("Minimum possible value")
                        Spacer()
                        Text("\(rangeMin)")
                    }
                    HStack{
                        Text("Maximum possible value")
                        Spacer()
                        Text("\(rangeMax)")
                    }
                    HStack{
                        Text("State space")
                        Spacer()
                        Text("\(stateSpace)")
                    }
                }
                
                Section(header: Text("Frequency Statistics"), footer: Text("Details will only show up if there is one type of die used (e.g. only d6).")) {
                    HStack{
                        Text("Single dice type")
                        Spacer()
                        Text("\(uniqueDice ? "d\(uniqueDiceValue!)" : "No")")
                    }
                    if uniqueDice {
                        HStack{
                            Text("Most frequent roll")
                            Spacer()
                            Text("\(mostFrequent)")
                        }
                        
                    }
                }
            }.navigationBarTitle("Dice Statistics")
            
        }
        
    }
}

struct StatsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StatsSheetView(diceMap: [:])
    }
}
