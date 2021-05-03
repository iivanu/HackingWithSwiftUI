//
//  ContentView.swift
//  TempConversion
//
//  Created by Ivan Ivanušić on 03.05.2021..
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = ""
    @State private var inputFormat = 0
    @State private var outputFormat = 1

    // 1 - Celsius, 2 - Fahrenheit, 3 - Kelvin
    let units = ["Celsius", "Farenheit", "Kelvin"]
    var outputValue: Double {
        // Convert input to Celsius
        let input = Double(inputValue.replacingOccurrences(of: ",", with: ".")) ?? 0
        var inputToCelsious: Double = 0
        if inputFormat == 1 {
            inputToCelsious = (input - 32) / 1.8
        } else if inputFormat == 2 {
            inputToCelsious = input - 273.15
        } else {
            inputToCelsious = input
        }
        
        
        if outputFormat == 1 {
            return  (inputToCelsious * 1.8) + 32
        } else if outputFormat == 2 {
            return inputToCelsious + 273.15
        }
        
        return inputToCelsious
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input temperature", text: $inputValue)
                        .keyboardType(.decimalPad)
                    Picker("Input format", selection: $inputFormat) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Picker("Output format", selection: $outputFormat) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Text("\(units[outputFormat]): \(outputValue, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("TempConversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
