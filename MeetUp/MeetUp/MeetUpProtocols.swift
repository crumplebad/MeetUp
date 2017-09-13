//
//  MeetUpProtocols.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 08/28/2017.
//  Copyright © 2017 iJay. All rights reserved.
//

import Foundation
import UIKit

protocol MeetUpWireFrameProtocol: class {
    static func getMeetUpView() -> MeetUpViewController
    /**
     * Add here your methods for communication PRESENTER -> WIREFRAME
     */
}

protocol MeetUpViewProtocol: class {
    var presenter: (MeetUpPresenterProtocol & UITableViewDataSource & UISearchBarDelegate)? { get set }
    /**
     * Add here your methods for communication PRESENTER -> VIEW
     */
    func eventsReturned(events: [Event], errorMessage: String?, applicationMessage: String?)
    func activityIndicatorAnimate(_ animate: Bool)
}

protocol MeetUpPresenterProtocol: class {
    var view: MeetUpViewProtocol? { get set }
    var interactor: MeetUpInteractorInputProtocol? { get set }
    var wireFrame: MeetUpWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getEvents(_ forText: String)
}

protocol MeetUpInteractorInputProtocol: class {
    var presenter: MeetUpInteractorOutputProtocol? { get set }
    var APIDataManager: MeetUpAPIDataManagerInputProtocol? { get set }
    var localDatamanager: MeetUpLocalDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func getEventsArray(_ forText: String)
    func addFavoriteEvent(_ eventId: String)
    func removeFavoriteEvent(_ eventId: String)
}

protocol MeetUpInteractorOutputProtocol: class {
    /**
     * Add here your methods for communication INTERACTOR -> PRESENTER
     */
    func eventsArrayReturned(_ events: [Event], errorMessage: String?, applicationMessage: String?)
}

protocol MeetUpAPIDataManagerInputProtocol: class {
    var interactor: MeetUpAPIDataManagerOutputProtocol? { get set }
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
    func getEventsFromServer(_ forText: String)
}

protocol MeetUpAPIDataManagerOutputProtocol: class {
    /**
     * Add here your methods for communication DATAMANAGER -> INTERACTOR
     */
    func eventsFromServerReturned(_ events: [Event]?)
}

protocol MeetUpLocalDataManagerInputProtocol: class {

    var interactor: MeetUpLocalDataManagerOutputProtocol? { get set }
    /**
    * Add here your methods for communication INTERACTOR -> LOCALDATAMANAGER
    */
    func getFavEventIDsFromLocal()
    func saveFavoriteEvent(_ eventId: String)
    func removeSavedFavoriteEvent(_ eventId: String)
}

protocol MeetUpLocalDataManagerOutputProtocol: class {
    /**
     * Add here your methods for communication LOCALDATAMANAGER -> INTERACTOR
     */
    func favEventIDsFromLocalReturned(_ eventIDs: NSSet)
}
