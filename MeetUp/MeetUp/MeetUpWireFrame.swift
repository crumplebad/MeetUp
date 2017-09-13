//
//  MeetUpWireFrame.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 08/28/2017.
//  Copyright © 2017 iJay. All rights reserved.
//

import Foundation
import UIKit

class MeetUpWireFrame: MeetUpWireFrameProtocol {

    class func getMeetUpView() -> MeetUpViewController {

        // Generating module components
        let view: MeetUpViewController = MeetUpViewController()
        let presenter: MeetUpPresenterProtocol & MeetUpInteractorOutputProtocol & UITableViewDataSource & UISearchBarDelegate = MeetUpPresenter()
        let interactor: MeetUpInteractorInputProtocol & MeetUpAPIDataManagerOutputProtocol & MeetUpLocalDataManagerOutputProtocol = MeetUpInteractor()
        let APIDataManager: MeetUpAPIDataManagerInputProtocol = MeetUpAPIDataManager()
        let localDataManager: MeetUpLocalDataManagerInputProtocol = MeetUpLocalDataManager()
        let wireFrame: MeetUpWireFrameProtocol = MeetUpWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        APIDataManager.interactor = interactor
        localDataManager.interactor = interactor

        return view
    }
}
