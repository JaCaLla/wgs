//
//  PeopleUseCase.swit
//  wgs
//
//  Created by 08APO0516 on 21/01/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation

class PeopleUseCase:NSObject {

    var injectedDataManager = DataManager()

    init(dataManager:DataManager = DataManager()) {
        self.injectedDataManager = dataManager
    }

    func getFirst(onSucceed : @escaping (([Person]) -> Void),
                  onFailed: @escaping ((ResponseCode) -> Void)) {
        injectedDataManager.getFirst(onSucceed:onSucceed,onFailed:onFailed)
    }

    func getNext(onSucceed : @escaping (([Person]) -> Void),
                 onFailed: @escaping ((ResponseCode) -> Void)) {
         injectedDataManager.getNext(onSucceed:onSucceed,onFailed:onFailed)
    }

    func remove(person:Person, onComplete: () -> Void = {/* Default empty block*/}) {
        self.injectedDataManager.remove(person: person, onComplete: onComplete)
    }

    func update(oldPerson:Person,newPerson:Person, onComplete: (Person) -> Void = { _ in /* Default empty block*/}) {

        self.injectedDataManager.update(oldPerson: oldPerson, newPerson: newPerson, onComplete: onComplete)
    }

    func getFetched(onComplete : @escaping (([Person]) -> Void)) {
        self.injectedDataManager.getFetched(onComplete: onComplete)
    }

}
