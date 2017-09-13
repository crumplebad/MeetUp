//
//  MeetUpPresenter.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 08/28/2017.
//  Copyright © 2017 iJay. All rights reserved.
//

import Foundation
import UIKit

class MeetUpPresenter: NSObject, MeetUpPresenterProtocol, MeetUpInteractorOutputProtocol, UITableViewDataSource, UISearchBarDelegate, EventTableViewCellProtocol {

    weak var view: MeetUpViewProtocol?
    var interactor: MeetUpInteractorInputProtocol?
    var wireFrame: MeetUpWireFrameProtocol?
    lazy var eventTableSource: [Event] = [Event]()

    func getEvents(_ forText: String) {
        self.interactor?.getEventsArray(forText)
    }

    func eventsArrayReturned(_ events: [Event], errorMessage: String?, applicationMessage: String?) {
        if !events.isEmpty {
            eventTableSource = events
        }
        self.view?.eventsReturned(events: events, errorMessage: errorMessage, applicationMessage: applicationMessage)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventTableSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        let event = eventTableSource[indexPath.row]
        cell.updateWithEvents(event)
        cell.delegate = self

        return cell
    }

    func favBtnTapped(eventId: String, isFav: Bool) {

        if isFav {
            self.interactor?.addFavoriteEvent(eventId)
        } else {
            self.interactor?.removeFavoriteEvent(eventId)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view?.activityIndicatorAnimate(true)
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else {
            searchBar.text = defaultSearchString
            getEvents(defaultSearchString)
            return
        }
        
        if searchText == "" {
            searchBar.text = defaultSearchString
            getEvents(defaultSearchString)
        } else {
            getEvents(searchText)
        }
    }
}
