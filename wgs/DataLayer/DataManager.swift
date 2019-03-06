//
//  DataManager.swift
//  MVVMRedux
//
//  Created by 08APO0516 on 28/01/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import SDWebImage

final class DataManager {

    // MARK: - Service helpers

    private var injectedAPIManager:APIManager = APIManager()

    init(npsAPIManager:APIManager = APIManager()) {
        self.injectedAPIManager = npsAPIManager
    }

    // MARK: - Service helpers



}

extension DataManager: Resetable {
    func reset() {
        self.injectedAPIManager = APIManager()

        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
}
