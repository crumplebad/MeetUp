//
//  MeetUpLocalDataManagerTests.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 8/31/17.
//  Copyright © 2017 iJay. All rights reserved.
//

import XCTest
@testable import MeetUp

class MeetUpLocalDataManagerTests: XCTestCase {
    var classUnderTest: MeetUpLocalDataManager!
    override func setUp() {
        super.setUp()
        classUnderTest = MeetUpLocalDataManager()
        classUnderTest.interactor = MeetUpInteractor()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        classUnderTest = nil
    }

    func testReadWriteSet() {
        let aSet  = NSMutableSet(array: ["a", "b", "c"])
        classUnderTest.writeFavEvents(aSet: aSet)
        let bSet = classUnderTest.readFavEvents()
        XCTAssert(bSet.count == 3, "count should be 3")
        for element in aSet {
            XCTAssert(bSet.contains(element), "element must be present")
        }
    }

    func testSaveFavoriteEvent() {
        classUnderTest.saveFavoriteEvent("a")
        let aSet = classUnderTest.readFavEvents()
        XCTAssert(aSet.contains("a"), "set should contain element a")
    }

    func testRemoveSavedFavoriteEvent() {
        classUnderTest.saveFavoriteEvent("a")
        classUnderTest.saveFavoriteEvent("b")
        classUnderTest.removeSavedFavoriteEvent("a")
        let aSet = classUnderTest.readFavEvents()
        XCTAssertFalse(aSet.contains("a"), "set should not contain element a")
    }
}
