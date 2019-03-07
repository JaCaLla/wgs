//
//  PresentMainAppOperation.swift
//  MVVMRedux
//
//

import Foundation

class PresentMainAppOperation: ConcurrentOperation {

    override init() {
        super.init()
    }

    override func main() {

        DispatchQueue.main.async {
            MainFlowCoordinator.shared.start()
            self.state = .finished
        }
    }
}
