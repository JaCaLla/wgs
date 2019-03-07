//
//  ViewModel.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 25/01/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation

enum PeopleListViewModelState: RawRepresentable {
    case initial
    case fetching
    case fetched([PersonAPI])
    case fetchedFailed

    func isInitial() -> Bool { return self == .initial }
    func isFetching() -> Bool { return self == .fetching }
    func isFetched() -> Bool { return self == . fetched([])}
    func isFetchedFailed() -> Bool { return self == .fetchedFailed }

    // MARK: - RawRepresentable
    typealias RawValue = String

    struct ViewModelStateValue {
        static let initial = "initial"
        static let fetching = "fetching"
        static let fetched = "fetched"
        static let fetchedFailed = "fetchedFailed"
    }

    init?(rawValue: RawValue) {
        switch rawValue {
        case ViewModelStateValue.initial: self = .initial
        case ViewModelStateValue.fetching: self = .fetching
        case ViewModelStateValue.fetched: return nil
        case ViewModelStateValue.fetchedFailed : self = .fetchedFailed
        default: return nil
        }
    }


    var rawValue: RawValue {
        switch self {
        case .initial: return ViewModelStateValue.initial
        case .fetching: return ViewModelStateValue.fetching
        case .fetched: return ViewModelStateValue.fetched
        case .fetchedFailed: return ViewModelStateValue.fetchedFailed
        }
    }
}

class PeopleListViewModel {

    var onStateChanged: ((PeopleListViewModelState) -> Void) = { _ in /* Default empty state */ }
    
    // MARK: - Private attributes

    var parksUseCase = PeopleUseCase()

    init(parksUseCase:PeopleUseCase = PeopleUseCase()) {
        self.parksUseCase = PeopleUseCase()

        onStateChanged(.fetching)

        parksUseCase.getFirst(onSucceed: { [weak self] parks in
            guard let weakSelf = self else { return }
            guard parks.count > 0 else {
                weakSelf.onStateChanged(.fetchedFailed)
                return
            }
            weakSelf.onStateChanged(.fetched(parks))
        }, onFailed: { _ in
            // TODO: Handle error
        })
    }


    func fetch() {

        onStateChanged(.fetching)
        parksUseCase.getNext(onSucceed: { [weak self] parks in
            guard let weakSelf = self else { return }
            guard parks.count > 0 else {
                weakSelf.onStateChanged(.fetchedFailed)
                return
            }
            weakSelf.onStateChanged(.fetched(parks))
            }, onFailed: { _ in
                // TODO: Handle error
        })

    }
}


