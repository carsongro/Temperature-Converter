//
//  ContentView.swift
//  Conversions
//
//  Created by Carson Gross on 5/23/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputAmount = 0.0
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Celsius"
    @FocusState private var tempIsFocused: Bool
    
    let units = ["Celsius", "Kelvin", "Fahrenheit"]
    
    var toCelsius: Double {
        if (inputUnit == "Celsius") {
            return inputAmount
        } else if (inputUnit == "Fahrenheit"){
            return ((inputAmount - 32) * 5 / 9)
        } else {
            return (inputAmount - 273.15)
        }
    }
    
    var toOutput: Double {
        if outputUnit == "Celsius" {
            return toCelsius
        } else if (outputUnit == "Kelvin") {
            return (toCelsius + 273.15)
        } else {
            return ((toCelsius * 9/5) + 32)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempIsFocused)
                } header: {
                    Text("Temperature")
                }
                
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("From")
                }
                .pickerStyle(.segmented)
                
                Section {
                    Picker("Input Unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("To")
                }
                .pickerStyle(.segmented)
                
                Section {
                    Text(toOutput.formatted())
                } header: {
                    Text("Temperature in \(outputUnit)")
                }
            }
            .navigationTitle("Conversions")
            
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        tempIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
