//
//  MeetUpAPIDataManager.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 08/28/2017.
//  Copyright © 2017 iJay. All rights reserved.
//

import Alamofire
import Foundation

class MeetUpAPIDataManager: MeetUpAPIDataManagerInputProtocol {
    weak var interactor: MeetUpAPIDataManagerOutputProtocol?
    init() {}

    func getEventsFromServer(_ forText: String) {
        let stringArray = forText.components(separatedBy: "_")

        let aUrl = String(format: "%@/2/open_events", Utility.baseURL())
        let header = ["Content-Type": "application/json"]
        let encode = URLEncoding.default
        let param: Parameters = [
            "and_text": false,
            "page": 10,
            "zip": stringArray[0],
            "radius": 100,
            "text": (stringArray.count > 1 ? stringArray[1] : stringArray[0]),
            "sign": true,
            "key": Utility.apiKey()
        ]

        Alamofire.request(aUrl, method: .get, parameters: param, encoding: encode, headers: header).responseJSON { (response: DataResponse) in

            guard let responseResulValue = response.result.value as? [String : Any] else {
                    self.interactor?.eventsFromServerReturned(nil)
                    return
            }
            guard let results = responseResulValue["results"] as? [Any] else {
                    self.interactor?.eventsFromServerReturned(nil)
                    return
            }
            guard let events = Events(array: results) else {
                self.interactor?.eventsFromServerReturned(nil)
                return
            }
            self.interactor?.eventsFromServerReturned(events.value)
        }
    }
}
