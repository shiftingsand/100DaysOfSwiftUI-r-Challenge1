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
        let timeSourceUnit = Measurement(value: Double(userAmount) ?? 0.0, unit: validUnits[sourceUnit])
        let theFinalResult = timeSourceUnit.converted(to: validUnits[desiredUnit])
        let shorterNumber : String
        var finalfinal : Double = 0

        // truncate the result. there are probably better ways of doing this.
        shorterNumber = String(format: myFormatter, theFinalResult.value)
        if let shorterNumber = Double(shorterNumber) {
            finalfinal = shorterNumber
        }
        
        return finalfinal
    }
        
    var body: some View {
        Form {
            Section(header: Text("Time Converter")) {
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
                // if the result is relatively short show the unit also. ignore decimal
                // if all zeroes follow it.
                if String(self.finalResult).count > lengthWithTrailing
                {
                    Text("\(self.finalResult, specifier: "%g")")
                } else {
                    Text("\(self.finalResult, specifier: "%g") \(unitName(validUnits[desiredUnit]))")
                }
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
