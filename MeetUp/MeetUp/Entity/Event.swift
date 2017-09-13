//
//  Event.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 8/29/17.
//  Copyright © 2017 iJay. All rights reserved.
//

import UIKit

struct Event {
    let eventId: String//id
    let eventName: String//name
    let groupName: String//group.name
//    var eventDateTime: UInt//time
//    var UTCoffset : Int//utc_offset
    let rsvpNumber: UInt//yes_rsvp_count
    var isFavorite: Bool//NO
    let eventDateTimeString: String
}

extension Event {

    init?(json: [String: Any]) {

        guard let eventId = json["id"] as? String else {
            return nil
        }
        self.eventId = eventId

        guard let eventName = json["name"] as? String else {
            return nil
        }
        self.eventName = eventName

        if let rsvpNumber = json["yes_rsvp_count"] as? UInt {
            self.rsvpNumber = rsvpNumber
        } else {
            self.rsvpNumber = 0
        }

        guard var eventDateTimeEpoc = json["time"] as? Int, var UTCoffset = json["utc_offset"] as? Int else {
            return nil
        }
        eventDateTimeEpoc /= 1_000
        UTCoffset /= 1_000
        eventDateTimeEpoc += UTCoffset
        let eventDateTime: Date = Date(timeIntervalSince1970:TimeInterval(eventDateTimeEpoc))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM, dd yyyy HH:mm a"
        self.eventDateTimeString = dateFormatter.string(from: eventDateTime)

        if let group = json["group"] as? [String : Any] {
            if let groupName = group["name"] as? String {
                self.groupName = groupName
            } else {
                self.groupName = ""
            }
        } else {
            self.groupName = ""
        }

        self.isFavorite = false
    }
}
