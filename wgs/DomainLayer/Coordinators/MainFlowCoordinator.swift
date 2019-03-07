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
       /*  npsSelectorPresenter.modalTransitionStyle = .crossDissolve
        npsSelectorPresenter.onParkSelected = { [weak self] park in
            guard let weakSelf = self else { return }
            weakSelf.presentNPSPictureSliderPresenter(park: park)
        }
*/
        mainFlowNavigationController.viewControllers = [peopleListPresenter]
         UIApplication.present(viewController: mainFlowNavigationController, animated: true, completion: nil)
    }

}
