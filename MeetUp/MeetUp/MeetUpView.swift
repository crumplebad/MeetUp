//
//  MeetUpView.swift
//  MeetUp
//
//  Created by Jay Gaonkar on 08/28/2017.
//  Copyright © 2017 iJay. All rights reserved.
//

import Foundation
import UIKit

class MeetUpViewController: UIViewController, MeetUpViewProtocol {
    var presenter: (MeetUpPresenterProtocol & UITableViewDataSource & UISearchBarDelegate)?
    var topRefershView: UIRefreshControl = UIRefreshControl()
    @IBOutlet private weak var eventsTableView: UITableView!
    @IBOutlet private weak var eventSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureSearchbar()
        activityIndicatorAnimate(true)
        eventSearchBar.text = defaultSearchString
        self.presenter?.getEvents(defaultSearchString)
    }

    func configureTable() {
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        eventsTableView.rowHeight = UITableViewAutomaticDimension
        eventsTableView.estimatedRowHeight = 119
        eventsTableView.dataSource = self.presenter
        self.eventsTableView.addSubview(topRefershView)
        topRefershView.addTarget(self, action:#selector(MeetUpViewController.pulledToReferesh), for:.valueChanged)
    }

    func configureSearchbar() {
        eventSearchBar.delegate = self.presenter
    }

    func activityIndicatorAnimate(_ animate: Bool) {
        if animate {
            topRefershView.beginRefreshing()
        } else {
            topRefershView.endRefreshing()
        }
    }

    func eventsReturned(events: [Event], errorMessage: String?, applicationMessage: String?) {
        activityIndicatorAnimate(false)
        if let errorMessage = errorMessage {
            Utility.showErrorMessageOn(errorMessage, viewController: self)
        } else if let applicationMessage = applicationMessage {
            Utility.showApplicationMessageOn(applicationMessage, viewController: self)
        } else if !events.isEmpty {
            eventsTableView.reloadData()
        }
    }

    func pulledToReferesh() {
        guard let searchText = eventSearchBar.text else {
            eventSearchBar.text = defaultSearchString
            self.presenter?.getEvents(defaultSearchString)
            return
        }
        if searchText == "" {
            eventSearchBar.text = defaultSearchString
            self.presenter?.getEvents(defaultSearchString)
        } else {
            self.presenter?.getEvents(searchText)
        }
    }
}
