//
//  MeetUpLocalDataManager.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 08/28/2017.
//  Copyright © 2017 iJay. All rights reserved.
//

import Foundation

class MeetUpLocalDataManager: MeetUpLocalDataManagerInputProtocol {
    weak var interactor: MeetUpLocalDataManagerOutputProtocol?
    init() {}

    func getFavEventIDsFromLocal() {
        self.interactor?.favEventIDsFromLocalReturned(readFavEvents())
    }

    func saveFavoriteEvent(_ eventId: String) {
        let aSet = readFavEvents()
        aSet.add(eventId)
        writeFavEvents(aSet: aSet)
    }

    func removeSavedFavoriteEvent(_ eventId: String) {
        let aSet = readFavEvents()
        aSet.remove(eventId)
        writeFavEvents(aSet: aSet)
    }

    func writeFavEvents(aSet: NSMutableSet) {
        let temp: NSArray = aSet.allObjects as NSArray
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let writePath = "\(documents)/file.plist"
        temp.write(toFile: writePath, atomically: true)
    }

    func readFavEvents() -> NSMutableSet {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let readPath = "\(documents)/file.plist"
        var  anArray: NSArray?
        if FileManager.default.fileExists(atPath: (readPath)) {
            anArray = NSArray(contentsOfFile: readPath)
        }
        guard let unWrappedArray = anArray as? [String] else {
            return NSMutableSet()
        }
        return NSMutableSet(array: unWrappedArray)
    }

}
