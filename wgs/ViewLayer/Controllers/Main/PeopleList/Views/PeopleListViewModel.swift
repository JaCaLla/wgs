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
    case fetched([Person])
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

    var injectedPeopleUseCase = PeopleUseCase()

    init(peopleUseCase:PeopleUseCase = PeopleUseCase()) {
        self.injectedPeopleUseCase = PeopleUseCase()

        onStateChanged(.fetching)

        peopleUseCase.getFirst(onSucceed: { [weak self] persons in
            guard let weakSelf = self else { return }
            guard persons.count > 0 else {
                weakSelf.onStateChanged(.fetchedFailed)
                return
            }
            weakSelf.onStateChanged(.fetched(persons))
        }, onFailed: { _ in
            // TODO: Handle error
        })
    }


    func fetch() {

        onStateChanged(.fetching)
        injectedPeopleUseCase.getNext(onSucceed: { [weak self] people in
            guard let weakSelf = self else { return }
            guard people.count > 0 else {
                weakSelf.onStateChanged(.fetchedFailed)
                return
            }
            weakSelf.onStateChanged(.fetched(people))
            }, onFailed: { _ in
                // TODO: Handle error
        })
    }

    func getFetched() {
        onStateChanged(.fetching)
        injectedPeopleUseCase.getFetched(onComplete: { [weak self] people in
            guard let weakSelf = self else { return }
            weakSelf.onStateChanged(.fetched(people))
        })
    }
}
