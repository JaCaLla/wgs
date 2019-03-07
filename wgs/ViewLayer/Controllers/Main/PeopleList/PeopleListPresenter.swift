//
//  PeopleListPresenter.swift
//  wgs
//
//  Created by 08APO0516 on 06/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit

class PeopleListPresenter: UIViewController {

      // MARK : - IBOutlets
    @IBOutlet weak var peopleListView: PeopleListView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Callbacks
    var onPersonSelected: (PersonAPI) -> Void = { _ in /* Default empty block*/}

    // MARK: - Privvate attributes
    private var injectedPeopleListViewModel = PeopleListViewModel()

    // MARK: - Constructor/Initializer
    static func instantiate() -> PeopleListPresenter {
        let peopleListPresenter = PeopleListPresenter.instantiate(fromAppStoryboard: .main)
        peopleListPresenter.injectedPeopleListViewModel = PeopleListViewModel()
        return peopleListPresenter
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupPresenter()
    }

/*
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        npsSelectorView.collectionViewLayout.invalidateLayout()
        npsSelectorView.setupView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        SDImageCache.shared().clearMemory()
    }

*/

    // MARK: - Private/Internal
    func setupPresenter() {

        self.title = R.string.localizable.nps_selector_title.key.localized
/*
        injectedViewModel.onStateChanged = { [weak self] newViewModelState in
            guard let weakSelf = self else { return }
            weakSelf.refreshView(viewModelState: newViewModelState)
        }

        npsSelectorView.onRequestForMore = { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.injectedViewModel.fetch()
        }
        npsSelectorView.onParkSelected = self.onParkSelected

        injectedViewModel.fetch()
 */
    }
/*
    func refreshView(viewModelState:ViewModelState) {
        switch viewModelState {
        case .initial: refreshInitialStateView()
        case .fetching: refreshFetchingStateView()
        case .fetched(let parks): refreshInitialStateView(parks: parks)
        case .fetchedFailed: refreshFetchingFailedStateView()
        }
    }

    func refreshInitialStateView() {
        activityIndicator.isHidden = false
    }

    func refreshFetchingStateView() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func refreshInitialStateView(parks:[Park]) {
        activityIndicator.isHidden = true
        npsSelectorView.parks = parks
    }

    func refreshFetchingFailedStateView() {
        activityIndicator.isHidden = true
        activityIndicator.startAnimating()
    }
*/
}
