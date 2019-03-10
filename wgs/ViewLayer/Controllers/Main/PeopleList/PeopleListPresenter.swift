//
//  PeopleListPresenter.swift
//  wgs
//
//  Created by 08APO0516 on 06/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit
import SDWebImage

class PeopleListPresenter: UIViewController {

      // MARK : - IBOutlets
    @IBOutlet weak var peopleListView: PeopleListView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
    // MARK: - Callbacks
    var onPersonSelected: (Person) -> Void = { _ in /* Default empty block*/}

    // MARK: - Privvate attributes
    private var injectedPeopleListViewModel:PeopleListViewModel = PeopleListViewModel()

    // MARK: - Constructor/Initializer
    static func instantiate(peopleListViewModel:PeopleListViewModel = PeopleListViewModel()) -> PeopleListPresenter {
        let peopleListPresenter = PeopleListPresenter.instantiate(fromAppStoryboard: .main)
        peopleListPresenter.injectedPeopleListViewModel = peopleListViewModel
        return peopleListPresenter
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPresenter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        SDImageCache.shared().clearMemory()
    }


    // MARK: - Private/Internal
    private func setupPresenter() {

        setupNavigationbar()

        activityIndicator.style = .whiteLarge

        injectedPeopleListViewModel.onStateChanged = { [weak self] newViewModelState in
            guard let weakSelf = self else { return }
            weakSelf.refreshView(peopleListViewModelState: newViewModelState)
        }

        peopleListView.onRequestForMore = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.injectedPeopleListViewModel.fetch()
        }
        peopleListView.onPersonSelected = self.onPersonSelected

        injectedPeopleListViewModel.fetch()

        NotificationCenter.default.addObserver(self, selector: #selector(onPersonDataUpdated),
                                               name: NSNotification.Name(rawValue: DataManager.NotificationId.deletedPerson),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onPersonDataUpdated),
                                               name: NSNotification.Name(rawValue: DataManager.NotificationId.updatedPerson),
                                               object: nil)
    }

    @objc func onPersonDataUpdated(notification: NSNotification) {
        injectedPeopleListViewModel.getFetched()
    }

    fileprivate func setupNavigationbar() {
        self.title = R.string.localizable.person_list_title.key.localized

        if let navigationController = self.navigationController {
            navigationController.navigationBar.barTintColor =  AppColors.PersonsList.Background
            navigationController.navigationBar.titleTextAttributes = [.foregroundColor: AppColors.PersonsList.TitleFontColor,
                                                                      .font: AppFonts.PersonsList.FirstFont]
        }
    }


    func refreshView(peopleListViewModelState:PeopleListViewModelState) {
        switch peopleListViewModelState {
        case .initial:              refreshInitialStateView()
        case .fetching:             refreshFetchingStateView()
        case .fetched(let persons): refreshInitialStateView(persons: persons)
        case .fetchedFailed:        refreshFetchingFailedStateView()
        }
    }

    func refreshInitialStateView() {
        activityIndicator.isHidden = false
    }

    func refreshFetchingStateView() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func refreshInitialStateView(persons:[Person]) {
        activityIndicator.isHidden = true
        peopleListView.people = persons
    }

    func refreshFetchingFailedStateView() {
        activityIndicator.isHidden = true
        activityIndicator.startAnimating()
    }
}
