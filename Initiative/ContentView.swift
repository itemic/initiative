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
    @State private var rollResult: Int = 0
    @State private var indivResults: String = ""
    @State private var indivResultsAsArray: [String] = []
    @State private var stepperValue = "1"
    @State private var showingSheet = false
    @State private var disableRoll = true
    
    let defaultDice = [4, 6, 8, 10, 12, 20]
    
    //    let defaultDice = [4, 6, 8]
    
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
        
        
        ZStack {
            Color.offWhite.edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 30) {
                
                Text("Dice Roll").font(.system(.largeTitle, design: .serif)).fontWeight(.heavy)
                
                VStack(spacing: 20) {
                    Group {
                        Text("Preset Dice").font(.system(.body, design: .serif)).fontWeight(.semibold).foregroundColor(.offWhiteDarker)
                        HStack(spacing:10) {
                            Button(action: {
                                self.addDie(value: 4)
                            }) {
                                HStack {
                                    Image(systemName: "4.square").imageScale(.large)
                                    Spacer()
                                    Text("Add d4")
                                }
                            }.buttonStyle(DiceButtonStyle())
                            
                            Button(action: {
                                self.addDie(value: 6)
                            }) {
                                HStack {
                                    Image(systemName: "6.square").imageScale(.large)
                                    Spacer()
                                    Text("Add d6")
                                }
                            }.buttonStyle(DiceButtonStyle())
                            
                            Button(action: {
                                self.addDie(value: 8)
                            }) {
                                HStack {
                                    Image(systemName: "8.square").imageScale(.large)
                                    Spacer()
                                    Text("Add d8")
                                }
                            }.buttonStyle(DiceButtonStyle())
                        }
                        
                        HStack(spacing:10) {
                            Button(action: {
                                self.addDie(value: 10)
                            }) {
                                HStack {
                                    Image(systemName: "10.square").imageScale(.large)
                                    Spacer()
                                    Text("Add d10")
                                }
                            }.buttonStyle(DiceButtonStyle())
                            
                            Button(action: {
                                self.addDie(value: 12)
                            }) {
                                HStack {
                                    Image(systemName: "12.square").imageScale(.large)
                                    Spacer()
                                    Text("Add d12")
                                }
                            }.buttonStyle(DiceButtonStyle())
                            
                            Button(action: {
                                self.addDie(value: 20)
                            }) {
                                HStack {
                                    Image(systemName: "20.square").imageScale(.large)
                                    Spacer()
                                    Text("Add d20")
                                }
                            }.buttonStyle(DiceButtonStyle())
                        }
                    }
                    
                    Group {
                        Text("Custom Value (TBA)").font(.system(.body, design: .serif)).fontWeight(.semibold).foregroundColor(.offWhiteDarker)
                        
                        HStack(spacing:10) {
                            Button(action: {
                                self.addDie(value: 100)
                            }) {
                                HStack {
                                    Image(systemName: "x.square").imageScale(.large)
                                    Spacer()
                                    Text("Add dX")
                                }
                            }.buttonStyle(DiceButtonLongStyle())
                            
                            Button(action: {
                                self.addDie(value: 100)
                            }) {
                                HStack {
                                    Image(systemName: "number.square").imageScale(.large)
                                    Spacer()
                                    Text("Add n")
                                }
                            }.buttonStyle(DiceButtonLongStyle())
                        }
                        
                    }
                    //                        Spacer()
                    
                    
                    
                } // vstack
               
                
                VStack(alignment: .center) {
                    GeometryReader { geometry in
                        ScrollView(.horizontal, showsIndicators: true) {
                            VStack {
                                HStack(alignment: .center, spacing: 5) {
                                    ForEach(self.diceList.selectedDice, id: \.id) {die in
                                        Button(action: {
                                            self.deleteDie(die: die)
                                            //
                                        }) {
                                            // design goes here
                                            DiceButtonView(diceValue: die.value, color: self.getColor(die.value))
                                            
                                        }
                                        
                                    }
                                }.frame(height: 60).frame(width: geometry.size.width)
                                Text("\(self.rollStatement.isEmpty ? " " : self.rollStatement)")
                            }
                        }
                    }.frame(height: 60)
                    
                } //Vstack
                
                
                
                 Spacer()
                VStack {
                   
                    
                    
                    //TODO: 0 isn't best in case of negative numbers later
                    Text("\(rollResult != 0 ? String(rollResult) : "!")")
                        .font(.system(size: 144, weight:.heavy, design: .rounded))
                    Text("\(indivResults)").font(.system(size: 24, weight:.light, design: .monospaced))
                    
                    
                   
                   
                }
              
                 Spacer()
                
                HStack(spacing: 15) {
                    Button(action: {
                        self.roll()
                    }) {
                        HStack{
                            Image(systemName: "cube").imageScale(.large)
                            //                                Spacer()
                            Text("Roll Dice").fontWeight(.semibold)
                        }.font(.body).frame(width:210, height: 15)
                            .padding(10)
                            .foregroundColor(diceList.selectedDice.isEmpty ? .gray : .black)
                            .background(Color.offWhite)
                            .cornerRadius(7.5)
                    }.disabled(diceList.selectedDice.isEmpty)
                    
                    Button(action: {
                        self.showingSheet.toggle()
                    }) {
                        HStack{
                            Image(systemName: "info.circle").imageScale(.large)
                            //                                Spacer()
                            Text("Stats").fontWeight(.semibold)
                        }.font(.body).frame(width:90, height: 15)
                            .padding(10)
                            .foregroundColor(.black)
                            .background(Color.offWhite)
                            .cornerRadius(7.5)
                    }.sheet(isPresented: $showingSheet) {
                        StatsSheetView(diceMap: self.diceMap)
                    }
                    
                    
                    
                }.frame(maxWidth: .infinity, maxHeight: 60).background(Color.offWhiteDarker).edgesIgnoringSafeArea(.all)
                
            }.edgesIgnoringSafeArea(.bottom)
        }
        
        
        
    }
    
    
    func getColor(_ diceValue: Int) -> Color {
        
        if diceValue == 4 {
            return .blue
        } else if diceValue == 6 {
            return .yellow
        } else if diceValue == 8 {
            return .orange
        } else if diceValue == 10 {
            return .green
        } else if diceValue == 12 {
            return .red
        } else if diceValue == 20 {
            return .purple
        } else {
            return .clear
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
        indivResultsAsArray = individualResults
        
        
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

struct DiceButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(.subheadline, design: .serif))
            .frame(width: 90, height: 20)
            .foregroundColor(.black)
            .padding(7.5)
            .background(Color.offWhite)
            .cornerRadius(7.5)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.7), radius: 5, x: -0, y: -0)
    }
}

struct DiceButtonLongStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(.subheadline, design: .serif))
            .frame(width: 150, height: 20)
            .foregroundColor(.black)
            .padding(7.5)
            .background(Color.offWhite)
            .cornerRadius(7.5)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
            .shadow(color: Color.white.opacity(0.7), radius: 5, x: -0, y: -0)
    }
}

extension Color {
    static let offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
    static let offWhiteLighter = Color(red: 235/255, green: 235/255, blue: 245/255)
    static let offWhiteDarker = Color(red: 75/255, green: 75/255, blue: 85/255)
}
