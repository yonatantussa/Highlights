//
//  WatchToiOSConnector.swift
//  Highlights Watch App
//
//  Created by Yonatan Tussa on 9/2/24.
//

import Foundation
import WatchConnectivity

class WatchToiOSConnector: NSObject, WCSessionDelegate, ObservableObject {
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func sendHighlightToiOS(highlight: String, date: Date) {
        print("Sending highlight to iOS")
        if session.isReachable {
            let message = [
                "highlight": highlight,
                "date": ISO8601DateFormatter().string(from:date)
            ]
            session.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message: \(error.localizedDescription)")
            }
            print(message)
        } else {
            print("iOS app is not reachable.")
            return
        }

        
        /*
         print("Sending highlight to iOS")
         guard session.isReachable else {
             print("iOS app is not reachable.")
             return
         }
         
         let message = [
             "highlight": highlight,
             "date": ISO8601DateFormatter().string(from:date)
         ]
         session.sendMessage(message, replyHandler: nil) { error in
             print("Error sending message: \(error.localizedDescription)")
         }
         print(message)
         */
    }
    
}
