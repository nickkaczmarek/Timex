//
//  TimexApp.swift
//  Timex
//
//  Created by Nick Kaczmarek on 7/20/21.
//

import SwiftUI

@main
struct TimexApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .commands {
//            CommandGroup(after: CommandGroupPlacement.toolbar) {
//                Button("Reload Page") {
//                    print("reloading")
//                }
//                .keyboardShortcut("r")
//                Divider()
//            }
//        }
    }
}
