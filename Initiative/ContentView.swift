//
//  ContentView.swift
//  Initiative
//
//  Created by Terran Kroft on 4/21/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    
    @State private var diceMap: [Int:Int] = [:]
    @State private var selectedDice: [Int] = []
    @State private var rollResult: Int = 0
    @State private var indivResults: String = ""
    
    let defaultDice = [4, 6, 8, 10, 12, 20]
    
    @ObservedObject var diceList = SelectedDice()
    
    
    
    
    
    var rollStatement: String {
        var components = [String]()
        for key in diceMap.keys.sorted(by: <) {
            if let value = diceMap[key] {
//                components.append("\(key)/\(value)")
                if value > 1 {
                    components.append("\(value)d\(key)")
                } else if value == 1 {
                   components.append("d\(key)")
                }
            }
        }
        
        print("a")
        return components.joined(separator: " + ")
//        return diceMap.values
    }
    
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Add die to roll").fontWeight(.bold).font(.largeTitle)
            
            HStack {
                
                ForEach(defaultDice, id: \.self) {value in
                    Button(action: {
                        // action goes here
                        self.addDie(value: value)
                    }) {
                        // design goes here
                        DiceButtonView(diceValue: value)
                            
                    }
                }
                
                
                
            }
            
            Text("\(rollStatement.isEmpty ? "" : rollStatement)")
//            Spacer()
         
            ScrollView(.horizontal) {
                HStack(spacing: 10) {

                    ForEach(diceList.selectedDice, id: \.id) {die in
                        
                        Button(action: {
                            self.deleteDie(die: die)
//
                        }) {
                            // design goes here
                            DiceButtonView(diceValue: die.value)
                                
                        }
                        
                    }
                    
                    
                           
                }.frame(minHeight: 80)
            }.frame(minHeight: 80)
                .background(Color.yellow)
            
//            Text("Roll?")
            Button(action: {
                self.roll()
            }) {
                Text("ROLL!")
            }
        
            //TODO: 0 isn't best in case of negative numbers later
            Text("\(rollResult != 0 ? String(rollResult) : "--")")
                .font(.system(size: 60, design: .rounded))
            Text("\(indivResults)")
        }
        
    }
    
    
    func addDie(value: Int) {
        // add to total dice map
        // add to current dice
        
        diceMap[value] = (diceMap[value] ?? 0) + 1
        let die = Dice(value: value)
        diceList.selectedDice.append(die)
    }
    
    func deleteDie(die: Dice) {
        
        // clear the result
        rollResult = 0
        indivResults = ""
        
        diceList.delete(die)
        let value = die.value
        
        // if it's not in there we can't go into negatives
        diceMap[value] = (diceMap[value] ?? 1) - 1
    }
    
    func roll() {
        // temporary
        var result = 0
        var individualResults = [String]()
        
        for dice in diceList.selectedDice {
            let rng = Int.random(in: 1...dice.value)
            result += rng
            individualResults.append(String(rng))
        }
        
        rollResult = result
        indivResults = individualResults.joined(separator: ", ")
        
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Dice: Identifiable {
    let id = UUID()
    let value: Int
}

class SelectedDice: ObservableObject {
    @Published var selectedDice = [Dice]()
    
    func delete(_ item: Dice) {
        self.selectedDice.removeAll(where: {$0.id == item.id})
    }
}
