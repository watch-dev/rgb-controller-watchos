//
//  RGBController_WatchApp.swift
//  RGBController-Watch WatchKit Extension
//
//  Created by omg on 2022/06/29.
//

import SwiftUI

@main
struct RGBController_WatchApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
