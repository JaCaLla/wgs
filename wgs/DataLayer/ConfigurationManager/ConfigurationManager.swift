//
//  ConfigurationManager.swift
//  wgs
//
//  Created by 08APO0516 on 08/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation

final class ConfigurationManager {

    // MARK: - Constants
    struct UserDefaultsKeys {
        static let lastPersistedPage = "lastPersistedPage"
    }


    static let shared:ConfigurationManager = ConfigurationManager()

    private init() { /* For not overwriting singleton*/ }

    // MARK: - lastPersistedPage
    func set(lastPersistedPage:Int) {

        UserDefaults.standard.set(lastPersistedPage, forKey: UserDefaultsKeys.lastPersistedPage)
        UserDefaults.standard.synchronize()
    }

    func getLastPersistedPage() -> Int? {
        return UserDefaults.standard.object(forKey: UserDefaultsKeys.lastPersistedPage) as? Int
    }


}

extension ConfigurationManager: Resetable {
    func reset() {

        _ = Array(UserDefaults.standard.dictionaryRepresentation().keys).map({  UserDefaults.standard.removeObject(forKey: $0) })
        UserDefaults.standard.synchronize()
    }
}
