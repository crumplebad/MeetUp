//
//  EventTableViewCell.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 8/29/17.
//  Copyright © 2017 iJay. All rights reserved.
//

import UIKit

protocol EventTableViewCellProtocol: class {
    func favBtnTapped(eventId: String, isFav: Bool)
}

class EventTableViewCell: UITableViewCell {

    @IBOutlet private weak var eventNameLabel: UILabel!
    @IBOutlet private weak var eventGroupLabel: UILabel!
    @IBOutlet private weak var eventDateTimeLabel: UILabel!
    @IBOutlet private weak var eventRSVPLabel: UILabel!
    @IBOutlet private weak var favBtn: UIButton!
    weak var delegate: EventTableViewCellProtocol?
    var eventId: String = ""
    var toggleFavState: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func favBtnTapped(_ sender: UIButton) {
        if toggleFavState {
            sender.setImage(UIImage(named: "not-fav"), for: .normal)
            toggleFavState = false
            self.delegate?.favBtnTapped(eventId: eventId, isFav: false)
        } else {
            sender.setImage(UIImage(named: "fav"), for: .normal)
            toggleFavState = true
            self.delegate?.favBtnTapped(eventId: eventId, isFav: true)
        }
    }

    func updateWithEvents(_ event: Event) {
        eventNameLabel.text = event.eventName
        eventGroupLabel.text = event.groupName
        eventDateTimeLabel.text = event.eventDateTimeString
        eventRSVPLabel.text = "\(event.rsvpNumber) are going."
        eventId = event.eventId
        if event.isFavorite {
            favBtn.setImage(UIImage(named:"fav"), for: .normal)
        } else {
            favBtn.setImage(UIImage(named:"not-fav"), for: .normal)
        }
        toggleFavState = event.isFavorite
    }
}
