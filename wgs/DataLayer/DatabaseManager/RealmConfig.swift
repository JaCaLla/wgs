//
//  RealmConfig.swift
//  iMug
//
//  Created by 08APO0516 on 18/10/2018.
//

import Foundation
import RealmSwift

enum RealmConfig {

    // MARK: - private configurations
    private static let mainConfig = Realm.Configuration(
        // Set the new schema version. This must be greater than the previously used
        // version (if you've never set a schema version before, the version is 0).
        schemaVersion: 0,

        // Set the block which will be called automatically when opening a Realm with
        // a schema version lower than the one set above
        migrationBlock: { migration, oldSchemaVersion in
            /* No migratins planned */
    }
    )

    private static let utestConfig = Realm.Configuration(fileURL: nil,
                                                         inMemoryIdentifier: "test",
                                                         syncConfiguration: nil,
                                                         encryptionKey: nil,
                                                         readOnly: false,
                                                         schemaVersion: 0,
                                                         migrationBlock: nil,
                                                         deleteRealmIfMigrationNeeded: true,
                                                         objectTypes: nil)

    // MARK: - enum cases
    case main
    case utest
    // MARK: - current configuration
    var configuration: Realm.Configuration {
        switch self {
        case .main:
            return RealmConfig.mainConfig
        case .utest:
            return RealmConfig.utestConfig
        }
    }
}
