//
//  RealmQueue.swift
//  DailyPlan
//
//  Created by Malik Timurkaev on 21.03.2025.
//

import Foundation

struct RealmQueue {
    let userInteractive: DispatchQueue
    
    init(serviceName: String) {
        
        userInteractive = DispatchQueue(
            label: "RealmUserInteractiveQueue_\(serviceName)",
            qos: .userInteractive)
    }
}
