//
//  ContentView.swift
//  memu-app
//
//  Created by Duy Nguyen on 7/5/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            TranslatorView()
                .tabItem {
                    Label("Translator", systemImage: "waveform")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            SettingsView()
                .tabItem {
                    Label("Settings",
                          systemImage: "person")}
        }
        .onAppear{
            initializeUserDefaults()
        }
    }
}

func initializeUserDefaults(){
    UserDefaults.standard.register(defaults: ["name" : "Anna Lee"])
    UserDefaults.standard.register(defaults: ["email" : "anna_lee@gmail.com"])
    UserDefaults.standard.register(defaults: ["phoneNum" : "0123456789"])
}

#Preview {
    ContentView()
}
