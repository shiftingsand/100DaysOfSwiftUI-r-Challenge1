//
//  ContentView.swift
//  Challenge1
//
//  Created by Chris Wu on 4/21/20.
//  Copyright © 2020 Chris Wu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let validUnits = [UnitDuration.milliseconds, UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours]
    @State var sourceUnit = 1
    @State var desiredUnit = 2
    @State var userAmount = ""
    let myFormatter = "%.4f"
    let lengthWithTrailing = 20
    
    var finalResult : Double {
        let timeInSeconds = Measurement(value: Double(userAmount) ?? 0.0, unit: validUnits[sourceUnit])
        let theFinalResult = timeInSeconds.converted(to: validUnits[desiredUnit])
        let shorterNumber : String
        var finalfinal : Double = 0

        if theFinalResult.value.rounded() == theFinalResult.value {
            print("\(Int.random(in: 0..<1000)) equal \(theFinalResult.value.rounded()) == \(theFinalResult.value)")
        } else {
            print("\(Int.random(in: 0..<1000)) different \(theFinalResult.value.rounded()) == \(theFinalResult.value)")
        }
        
        shorterNumber = String(format: myFormatter, theFinalResult.value)
        if let shorterNumber = Double(shorterNumber) {
            finalfinal = shorterNumber
        }
        
        print("returning \(finalfinal)")
        return finalfinal
    }
        
    var body: some View {
        Form {
            Section(header: Text("How much time?")) {
                TextField("Enter amount you want to convert", text: $userAmount).keyboardType(UIKeyboardType.decimalPad)
            }
            
            Section (header: Text("Source unit")) {
                Picker("Source unit", selection: $sourceUnit) {
                    ForEach(0..<self.validUnits.count) { indexer in
                        Text(self.unitName(self.validUnits[indexer]))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section (header: Text("Desired unit")) {
                Picker("Desired unit", selection: $desiredUnit) {
                    ForEach(0..<self.validUnits.count) { indexer in
                        Text(self.unitName(self.validUnits[indexer]))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section (header: Text("Converted time in \(unitName(validUnits[desiredUnit]))")) {
                if String(self.finalResult).count > lengthWithTrailing
                {
                   // ? nil : unitName(self.validUnits[desiredUnit])
              //  var resultToPrint = String(format: finalResult == finalResult.rounded() ? "%.0f" : "%.5f", finalResult)
//                if finalResult == finalResult.rounded() {
//                    Text("\(self.finalResult, specifier: "%.0f")")
//                } else {
//                    Text("\(self.finalResult, specifier: "%.2f")")
//                }
                    Text("\(self.finalResult, specifier: finalResult == finalResult.rounded() ? "%.0f" : myFormatter)")
                } else {
                    Text("\(self.finalResult, specifier: finalResult == finalResult.rounded() ? "%.0f" : myFormatter) \(unitName(validUnits[desiredUnit]))")
                }
                
//                if let trailing = trailing {
//                    Text("\(resultToPrint) \(trailing)")
//                } else {
//                    Text("\(resultToPrint)")
//                }
            }
        }
    }
    
    func unitName(_ theUnit : UnitDuration) -> String {
        switch theUnit {
        case UnitDuration.milliseconds:
            return "millisecs"
        case UnitDuration.seconds:
            return "seconds"
        case UnitDuration.minutes:
            return "minutes"
        case UnitDuration.hours:
            return "hours"
        default:
            return "ERROR"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
