//
//  UTPersonDetailViewModel.swift
//  wgsTests
//
//  Created by 08APO0516 on 10/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import XCTest
@testable import wgs
class UTPersonDetailViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        DataManager.shared.reset()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_presentPerson_edit() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)

        let personDetailViewModel = PersonDetailViewModel(person: person1)
        personDetailViewModel.onStateChanged = { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .edit)
        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNil(personDetailViewModel.getNewEmail())
        XCTAssertNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),false)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newEmail)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newFirst)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newImage)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), false)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), true)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"< Back")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Edit")

         asyncExpectation.fulfill()
        self.waitForExpectations(timeout:10, handler: nil)

    }

    func test_presentPerson_save() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)

        let personDetailViewModel = PersonDetailViewModel(person: person1)
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .edit)
        personDetailViewModel.onRightButtonAction() // Press on Edit button
        personDetailViewModel.onStateChanged = { _ in
            XCTFail()
            asyncExpectation.fulfill()
        }
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .save)
        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNil(personDetailViewModel.getNewEmail())
        XCTAssertNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),false)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newEmail)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newFirst)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newImage)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), false)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), false)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"Cancel")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Done")

        asyncExpectation.fulfill()
        self.waitForExpectations(timeout:10, handler: nil)

    }

    func test_presentPerson_cancel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)

        let personDetailViewModel = PersonDetailViewModel(person: person1)
        personDetailViewModel.onStateChanged = { personDetailViewModelState in
            XCTAssertEqual(personDetailViewModelState.isBack(), true)
            asyncExpectation.fulfill()
        }
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .edit)
        personDetailViewModel.onLeftButtonAction() // Press Left back button
        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNil(personDetailViewModel.getNewEmail())
        XCTAssertNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),false)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newEmail)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newFirst)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newImage)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), false)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), true)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"< Back")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Edit")

        self.waitForExpectations(timeout:10, handler: nil)
    }

    func test_presentPerson_setEmailAndFirst_cancel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)

        let personDetailViewModel = PersonDetailViewModel(person: person1)
        var expected = PersonDetailViewModelState.save(person1)
        personDetailViewModel.onStateChanged = { personDetailViewModelState in
            guard expected.rawValue == personDetailViewModelState.rawValue else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }
            if expected.rawValue == PersonDetailViewModelState.save(person1).rawValue &&
                personDetailViewModelState.rawValue == PersonDetailViewModelState.save(person1).rawValue {
                expected = PersonDetailViewModelState.editing(person1)
            } else if expected.rawValue == PersonDetailViewModelState.editing(person1).rawValue &&
                personDetailViewModelState.rawValue == PersonDetailViewModelState.editing(person1).rawValue {
                 asyncExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .edit)
         personDetailViewModel.onRightButtonAction() // Press Left back button
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .save)

        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNil(personDetailViewModel.getNewEmail())
        XCTAssertNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),false)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newEmail)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newFirst)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newImage)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), false)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), false)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"Cancel")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Done")


        personDetailViewModel.onLeftButtonAction() // Press Left back button
        personDetailViewModel.set(newEmail: "patata")
        personDetailViewModel.set(newFirst: "alcachofa")

        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNotNil(personDetailViewModel.getNewEmail())
        XCTAssertNotNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),true)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().newEmail,"patata")
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().newFirst,"alcachofa")
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newImage)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), true)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), true)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"< Back")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Edit")


        self.waitForExpectations(timeout:10, handler: nil)
    }

    func test_presentPerson_setImage_cancel() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)
        DatabaseManager.shared.add(person: person1)
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)

        let personDetailViewModel = PersonDetailViewModel(person: person1)
       // var expected = PersonDetailViewModelState.save(person1)

        let expectedSeq:[PersonDetailViewModelState] = [PersonDetailViewModelState.save(person1),
                                                        PersonDetailViewModelState.editing(person1),
                                                        PersonDetailViewModelState.save(person1)]
        var index = 0
        personDetailViewModel.onStateChanged = { personDetailViewModelState in
            guard index < expectedSeq.count else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }
            guard expectedSeq[index].rawValue == personDetailViewModelState.rawValue else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }

            index += 1
            if index == expectedSeq.count {
                asyncExpectation.fulfill()
            }
        }
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .edit)
        personDetailViewModel.onRightButtonAction() // Press Left back button
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .save)

        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNil(personDetailViewModel.getNewEmail())
        XCTAssertNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),false)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newEmail)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newFirst)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newImage)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), false)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), false)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"Cancel")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Done")


        personDetailViewModel.onLeftButtonAction() // Press Left back button
        personDetailViewModel.set(newImage: R.image.default_profile()!)

        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNil(personDetailViewModel.getNewEmail())
        XCTAssertNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),true)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().newImage,R.image.default_profile()!)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), true)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), true)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"< Back")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Edit")


        self.waitForExpectations(timeout:10, handler: nil)
    }

    func test_presentPerson_delete() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)
        DatabaseManager.shared.add(person: person1)
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)

        let personDetailViewModel = PersonDetailViewModel(person: person1)
        var expected = PersonDetailViewModelState.save(person1)
        personDetailViewModel.onStateChanged = { personDetailViewModelState in
            guard expected.rawValue == personDetailViewModelState.rawValue else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }
            if expected.rawValue == PersonDetailViewModelState.save(person1).rawValue &&
                personDetailViewModelState.rawValue == PersonDetailViewModelState.save(person1).rawValue {
                expected = PersonDetailViewModelState.busy
            } else if expected.rawValue == PersonDetailViewModelState.busy.rawValue &&
                personDetailViewModelState.rawValue == PersonDetailViewModelState.busy.rawValue {
                expected = PersonDetailViewModelState.back
            } else if expected.rawValue == PersonDetailViewModelState.back.rawValue &&
                personDetailViewModelState.rawValue == PersonDetailViewModelState.back.rawValue {

                 XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
                asyncExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .edit)
        personDetailViewModel.onRightButtonAction() // Press Left back button
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .save)
        personDetailViewModel.delete()


        self.waitForExpectations(timeout:10, handler: nil)
    }


    func test_presentPerson_setEmailAndFirst_done() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)
        DatabaseManager.shared.add(person: person1)
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)

        let personDetailViewModel = PersonDetailViewModel(person: person1)
        var expected = PersonDetailViewModelState.save(person1)
        personDetailViewModel.onStateChanged = { personDetailViewModelState in
            guard expected.rawValue == personDetailViewModelState.rawValue else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }
            if expected.rawValue == PersonDetailViewModelState.save(person1).rawValue &&
                personDetailViewModelState.rawValue == PersonDetailViewModelState.save(person1).rawValue {
                expected = PersonDetailViewModelState.busy
            } else if expected.rawValue == PersonDetailViewModelState.busy.rawValue &&
                personDetailViewModelState.rawValue == PersonDetailViewModelState.busy.rawValue {
                expected = PersonDetailViewModelState.editing(person1)
            } else if expected.rawValue == PersonDetailViewModelState.editing(person1).rawValue &&
                personDetailViewModelState.rawValue == PersonDetailViewModelState.editing(person1).rawValue {

                XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)
                asyncExpectation.fulfill()
            } else {
                XCTFail()
            }
        }
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .edit)
        personDetailViewModel.onRightButtonAction() // Press Right edit
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .save)

        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNil(personDetailViewModel.getNewEmail())
        XCTAssertNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),false)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newEmail)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newFirst)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newImage)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), false)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), false)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"Cancel")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Done")


        personDetailViewModel.set(newEmail: "patata")
        personDetailViewModel.set(newFirst: "alcachofa")

        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNotNil(personDetailViewModel.getNewEmail())
        XCTAssertNotNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),true)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().newEmail,"patata")
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().newFirst,"alcachofa")
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newImage)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), true)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), true)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"Cancel")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Done")

         personDetailViewModel.onRightButtonAction() // Press Right done

        self.waitForExpectations(timeout:10, handler: nil)
    }

    func test_presentPerson_setImage_done() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let asyncExpectation = expectation(description: "\(#function)")

        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 0)
        let person1 = Person(email: "a", first: "b", latitude: "c", longitude: "d", thumbnail: "e",large:"f" ,image: nil)
        DatabaseManager.shared.add(person: person1)
        XCTAssertEqual(DatabaseManager.shared.getPersons().count, 1)

        let personDetailViewModel = PersonDetailViewModel(person: person1)
        let expectedSeq:[PersonDetailViewModelState] = [PersonDetailViewModelState.save(person1),
        PersonDetailViewModelState.save(person1),
        PersonDetailViewModelState.busy,
        PersonDetailViewModelState.editing(person1),
        PersonDetailViewModelState.save(person1)]
        var index = 0
        personDetailViewModel.onStateChanged = { personDetailViewModelState in
            guard index < expectedSeq.count else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }
            guard expectedSeq[index].rawValue == personDetailViewModelState.rawValue else {
                XCTFail()
                asyncExpectation.fulfill()
                return
            }

            index += 1
            if index == expectedSeq.count {
                asyncExpectation.fulfill()
            }
        }
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .edit)
        personDetailViewModel.onRightButtonAction() // Press Right edit  button
        XCTAssertEqual(personDetailViewModel.getPersonDetailPresenterMode(), .save)
        personDetailViewModel.set(newImage: R.image.default_profile()!)

        XCTAssertEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNil(personDetailViewModel.getNewEmail())
        XCTAssertNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),true)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newEmail)
        XCTAssertNil(personDetailViewModel.getPersonDetailAttributesUpdated().newFirst)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().newImage,R.image.default_profile()!)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), true)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), true)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"Cancel")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Done")


        personDetailViewModel.onRightButtonAction() // Press Done
        personDetailViewModel.set(newImage: R.image.default_profile()!)

        XCTAssertNotEqual(person1, personDetailViewModel.getPerson())
        XCTAssertNotNil(personDetailViewModel.getPersonDetailAttributesUpdated().newImage)
        XCTAssertNil(personDetailViewModel.getNewEmail())
        XCTAssertNil(personDetailViewModel.getNewFirst())
        XCTAssertEqual(personDetailViewModel.existsAttributesUpdated(),true)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().newImage,R.image.default_profile()!)
        XCTAssertEqual(personDetailViewModel.getPersonDetailAttributesUpdated().existsAttributesUpdated(), true)
        XCTAssertEqual(personDetailViewModel.isEnabledRightButtton(), true)
        XCTAssertEqual(personDetailViewModel.getTitleLeftButton(),"< Back")
        XCTAssertEqual(personDetailViewModel.getTitleRightButton(),"Edit")


        self.waitForExpectations(timeout:10, handler: nil)
    }
}
