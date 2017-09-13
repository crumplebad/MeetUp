//
//  Events.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 8/29/17.
//  Copyright © 2017 iJay. All rights reserved.
//

import UIKit

struct Events {
    let value: [Event]
}

extension Events {

    init?(array:[Any]) {
        var value: [Event]=[]
        for item in array {
            if let item = item as? [String : Any] {
                if let incident = Event(json: item ) {
                    value.append(incident)
                }
            }
        }
        self.value = value
    }
}
