//
//  MeetUpInteractorTests.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 9/1/17.
//  Copyright © 2017 iJay. All rights reserved.
//

import XCTest
@testable import MeetUp

class MeetUpInteractorTests: XCTestCase {
    var classUnderTest: MeetUpInteractor!
    override func setUp() {
        super.setUp()
        classUnderTest = MeetUpInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        classUnderTest = nil
    }

    func testFavEventIDsFromLocalReturned() {

        let eventA = Event(eventId: "a", eventName: "Aname", groupName: "Agroup", rsvpNumber: 1, isFavorite: false, eventDateTimeString: "DNM")
        let eventB = Event(eventId: "b", eventName: "Bname", groupName: "Bgroup", rsvpNumber: 1, isFavorite: false, eventDateTimeString: "DNM")

        classUnderTest.eventsWoFav = [eventA, eventB]
        let test = MockPresenter()
        classUnderTest.presenter = test
        classUnderTest.favEventIDsFromLocalReturned(NSSet(array: ["b"]))
    }

    class MockPresenter: NSObject, MeetUpPresenterProtocol, MeetUpInteractorOutputProtocol {
        weak var view: MeetUpViewProtocol?
        var interactor: MeetUpInteractorInputProtocol?
        var wireFrame: MeetUpWireFrameProtocol?

        func getEvents(_ forText: String) {

        }

        func eventsArrayReturned(_ events: [Event], errorMessage: String?, applicationMessage: String?) {
            XCTAssertFalse(events[0].isFavorite, "isFavorite should be false")
            XCTAssert(events[1].isFavorite, "isFavorite should be true")
        }
    }
}
