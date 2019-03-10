//
//  BuyCoordinator.swift
//  MVVMRedux
//
//

import Foundation
import UIKit

class MainFlowCoordinator {

    // MARK: - Singleton handler
    static let shared =  MainFlowCoordinator()

    // MARK: - Private attributes
    private let mainFlowNavigationController =  UINavigationController()


    private init() { /*This prevents others from using the default '()' initializer for this class. */ }

    // MARK: - Pulic methods
    func start()   {
       return self.presentPeopleList()
    }

    // MARK: - Private/Internal
    private func presentPeopleList()  {
        let peopleListPresenter = PeopleListPresenter.instantiate()
         peopleListPresenter.modalTransitionStyle = .crossDissolve
        peopleListPresenter.onPersonSelected = { [weak self] person in
            guard let weakSelf = self else { return }
            weakSelf.presentDetails(person: person)
        }

        mainFlowNavigationController.viewControllers = [peopleListPresenter]
         UIApplication.present(viewController: mainFlowNavigationController, animated: true, completion: nil)
    }

    private func presentDetails(person:Person) {
        let personDetailPresenter:PersonDetailPresenter = PersonDetailPresenter.instantiate(person: person)
        personDetailPresenter.onDismiss = { [weak self]  in
            guard let weakSelf = self else { return }
            weakSelf.mainFlowNavigationController.popViewController(animated: true)
        }

        mainFlowNavigationController.pushViewController(personDetailPresenter, animated: true)

    }

}
