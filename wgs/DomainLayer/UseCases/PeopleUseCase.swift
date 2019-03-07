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

    func getFirst(onSucceed : @escaping (([PersonAPI]) -> Void),
                  onFailed: @escaping ((ResponseCode) -> Void)) {
      //  injectedDataManager.getFirst(onSucceed:onSucceed,onFailed:onFailed)
    }

    func getNext(onSucceed : @escaping (([PersonAPI]) -> Void),
                 onFailed: @escaping ((ResponseCode) -> Void)) {
//         injectedDataManager.getNext(onSucceed:onSucceed,onFailed:onFailed)
    }

}
