//
//  ContentView.swift
//  Initiative
//
//  Created by Terran Kroft on 4/21/20.
//  Copyright © 2020 itemic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var d4 = 0
    @State private var d6 = 0
    @State private var d20 = 0
    
    @State private var diceMap: [Int:Int] = [:]
    @State private var selectedDice: [Int] = []
    
    @ObservedObject var diceList = SelectedDice()
    
    
    
    
    
    var rollStatement: String {
        
        let d4Statement = d4 == 0 ? "" : "\(d4)d4 "
        let d6Statement = d6 == 0 ? "" : "\(d6)d6 "
        let d20Statement = d20 == 0 ? "" : "\(d20)d20"
        
        return "\(d4Statement)\(d6Statement)\(d20Statement)"
    }
    
    
    var body: some View {
        VStack(spacing: 10) {
            
            Text("Add die to roll...").fontWeight(.bold).font(.largeTitle)
            HStack {
                Button(action: {
                    // action goes here
                    self.addDie(value: 4)
                }) {
                    // design goes here
                    DiceButtonView(diceValue: 4)
                        
                }
                
                Button(action: {
                    // action goes here
                    self.addDie(value: 6)
                }) {
                    // design goes here
                    DiceButtonView(diceValue: 6)
                }
                
            }
            
            Text("Rolling \(rollStatement)")
//            Spacer()
         
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    Text("x")
                    Text("y")
                    
                    ForEach(diceList.selectedDice, id: \.id) {die in
                        
                        Button(action: {
//                            self.removeDie(at: die.id)
                            self.diceList.delete(die)
//
                        }) {
                            // design goes here
                            DiceButtonView(diceValue: die.value)
                                
                        }
                        
                    }.onDelete(perform: removeDie)
                    
                    
                           
                }.frame(minHeight: 100)
                    .background(Color.green)
            }.frame(minHeight: 100)
                .background(Color.yellow)
            
            
            
        }
        
    }
    
    func incrementD4() {
        d4 += 1
    }
    
    func incrementD6() {
        d6 += 1
    }
    func incrementD20() {
        d20 += 1
    }
    
    func addDie(value: Int) {
        // add to total dice map
        // add to current dice
        
        diceMap[value] = diceMap[value] ?? 0 + 1
        selectedDice.append(value)
        let die = Dice(value: value)
        diceList.selectedDice.append(die)
    }
    
    
    func removeDie(with index: Int) {
        diceList.selectedDice.remove(at: index)
    }
    func removeDie(at offsets: IndexSet) {
        diceList.selectedDice.remove(atOffsets: offsets)
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
