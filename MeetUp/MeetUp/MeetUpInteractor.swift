//
//  MeetUpInteractor.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 08/28/2017.
//  Copyright © 2017 iJay. All rights reserved.
//

import Foundation

class MeetUpInteractor: MeetUpInteractorInputProtocol, MeetUpAPIDataManagerOutputProtocol, MeetUpLocalDataManagerOutputProtocol {

    weak var presenter: MeetUpInteractorOutputProtocol?
    var APIDataManager: MeetUpAPIDataManagerInputProtocol?
    var localDatamanager: MeetUpLocalDataManagerInputProtocol?
    var eventsWithOutFavorites: [Event] = Array()
    var errorMessage: String?
    var applicationMessage: String?

    init() {}

    func getEventsArray(_ forText: String) {
        self.APIDataManager?.getEventsFromServer(forText)
    }

    func eventsFromServerReturned(_ events: [Event]?) {
        if let events = events {
            if !events.isEmpty {
                eventsWithOutFavorites = events
                self.localDatamanager?.getFavEventIDsFromLocal()
            } else {
                self.presenter?.eventsArrayReturned(Array(), errorMessage: nil, applicationMessage: "No Results!.\n Please make sure your search string is correct format and try again.")
            }
        } else {
            self.presenter?.eventsArrayReturned(Array(), errorMessage: "Something went wrong\n Try again later please.", applicationMessage: nil)//Compute appropriate error message
        }
    }

    func addFavoriteEvent(_ eventId: String) {
        self.localDatamanager?.saveFavoriteEvent(eventId)
    }

    func removeFavoriteEvent(_ eventId: String) {
        self.localDatamanager?.removeSavedFavoriteEvent(eventId)
    }

    func favEventIDsFromLocalReturned(_ eventIDs: NSSet) {
        var eventsWithFavorites: [Event] = Array()
        for var event in eventsWithOutFavorites {
            if eventIDs.contains(event.eventId) {
                event.isFavorite = true
            } else {
                event.isFavorite = false
            }
            eventsWithFavorites.append(event)
        }
        self.presenter?.eventsArrayReturned(eventsWithFavorites, errorMessage: nil, applicationMessage: nil)
    }
}
