//
//  ContentView.swift
//  Highlights Watch App
//
//  Created by Yonatan Tussa on 9/2/24.
//

import SwiftUI

struct WatchContentView: View {
    @StateObject var watchConnector = WatchToiOSConnector()
    @State var highlight = ""
    @State var date = Date.now
    // private let connector = WatchToiOSConnector()

    var body: some View {
        VStack {
            TextField("Start a Highlight", text: $highlight)
            
            Button {
                sendHighlight()
            } label: {
                Text("Go")
            }
            .disabled(highlight == "")
        }
        .padding()
        .ignoresSafeArea()
    }
    
    func sendHighlight() {
        watchConnector.sendHighlightToiOS(highlight: highlight, date: date)
    }
}

#Preview {
    WatchContentView()
}
