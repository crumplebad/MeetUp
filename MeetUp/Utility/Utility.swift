//
//  Utility.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 8/29/17.
//  Copyright © 2017 iJay. All rights reserved.
//

import UIKit

class Utility: NSObject {

    class func baseURL() -> String {
        return "https://api.meetup.com"
    }

    static func apiKey() -> String {
        //6752511f3291b2b182ee4d2ef312
        //this does not work, to be Obfuscated
        let fixed: [Character] = ["6", "7", "5", "2", "5", "1", "1", "f", "3", "2", "9", "1", "b", "2", "b", "1", "8", "2", "e", "e", "4", "d", "2", "e", "f", "3", "1", "2" ]
        return String(fixed)
    }

    class func showErrorMessageOn(_ errorMessage: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        viewController.present(alert, animated: true, completion: nil)
    }

    class func showApplicationMessageOn(_ applicationMessage: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "MeetUp Message", message: applicationMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
