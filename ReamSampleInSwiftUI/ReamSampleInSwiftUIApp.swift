//
//  ReamSampleInSwiftUIApp.swift
//  ReamSampleInSwiftUI
//
//  Created by ryo muranaka on 2023/11/20.
//

import SwiftUI
import RealmSwift

@main
struct ContentView: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            LocalOnlyContentView()
        }
    }
}
