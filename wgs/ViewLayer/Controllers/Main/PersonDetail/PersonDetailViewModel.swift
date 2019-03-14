//
//  PresenterDetailViewModel.swift
//  wgs
//
//  Created by 08APO0516 on 10/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import Foundation
import CocoaLumberjack
import UIKit

enum PersonDetailViewModelState: RawRepresentable {
    case editing(Person)
    case save(Person)
    case busy
    case deleted
    case back

    func isEditing() -> Bool { return self == .editing(Person()) }
    func isSave() -> Bool { return self == .save(Person()) }
    func isBusy() -> Bool { return self == .busy }
    func isDeleted() -> Bool { return self == .deleted }
    func isBack() -> Bool { return self == .back }

    // MARK: - RawRepresentable
    typealias RawValue = String

    struct PersonDetailViewModelStateValue {
        static let editing = "editing"
        static let save = "save"
        static let busy = "busy"
        static let deleted = "deleted"
        static let back = "back"
    }

    init?(rawValue: RawValue) {
        switch rawValue {
        case PersonDetailViewModelStateValue.editing: self = .editing(Person())
        case PersonDetailViewModelStateValue.save: self = .save(Person())
        case PersonDetailViewModelStateValue.busy: self = .busy
        case PersonDetailViewModelStateValue.deleted: self = .deleted
        case PersonDetailViewModelStateValue.back: self = .back
        default: return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .editing: return PersonDetailViewModelStateValue.editing
        case .save: return PersonDetailViewModelStateValue.save
        case .busy: return PersonDetailViewModelStateValue.busy
        case .deleted: return PersonDetailViewModelStateValue.deleted
        case .back: return PersonDetailViewModelStateValue.back
        }
    }
}

struct PersonDetailAttributesUpdated {
    var newEmail:String?
    var newFirst:String?
    var newImage:UIImage?

    func existsAttributesUpdated() -> Bool {
        return (self.newEmail != nil ||
            self.newFirst != nil ||
            self.newImage != nil)
    }
}

enum PersonDetailPresenterMode: Int {
    case edit
    case save

    func getTitleRightButton() -> String {
        switch self {
        case .edit: return R.string.localizable.person_detail_edit.key.localized
        case .save: return R.string.localizable.person_detail_save.key.localized
        }
    }

    func getTitleLeftButton() -> String {
        switch self {
        case .edit: return R.string.localizable.person_detail_back.key.localized
        case .save: return R.string.localizable.person_detail_cancel.key.localized
        }
    }

    func isEdit() -> Bool { return self == .edit }
    func isSave() -> Bool { return self == .save }
}

class PersonDetailViewModel {

    // MARK: - Callbacks
    var onStateChanged: ((PersonDetailViewModelState) -> Void) = { _ in /* Default empty state */ }

    // MARK: - Private attributes
    private var injectedPeopleUseCase = PeopleUseCase()
    private var person: Person = Person()
    private var attributeUpdated:PersonDetailAttributesUpdated = PersonDetailAttributesUpdated()
    private var personDetailPresenterMode:PersonDetailPresenterMode = .edit

    init(person:Person,
         peopleUseCase:PeopleUseCase = PeopleUseCase()) {
        self.person = person
        self.injectedPeopleUseCase = PeopleUseCase()

        onStateChanged(.editing(self.person))
    }

    // MARK: - Person
    func getPerson() -> Person {
        return self.person
    }

    // MARK: - Email
    func getNewEmail() -> String? {
        return self.attributeUpdated.newEmail
    }

    func set(newEmail:String) {
        self.attributeUpdated.newEmail = newEmail
    }

    // MARK: - First
    func getNewFirst() -> String? {
        return self.attributeUpdated.newFirst
    }

    func set(newFirst:String) {
        self.attributeUpdated.newFirst = newFirst
    }

    // MARK: - Image
    func set(newImage:UIImage) {
        self.attributeUpdated.newImage = newImage
         self.onStateChanged(.save(self.person))
    }
    func getPersonDetailAttributesUpdated() -> PersonDetailAttributesUpdated {
        return self.attributeUpdated
    }

    // MARK: - Public helpers
    func existsAttributesUpdated() -> Bool {
        return self.attributeUpdated.existsAttributesUpdated()
    }

    // MARK: - personDetailPresenterMode
    func getPersonDetailPresenterMode() -> PersonDetailPresenterMode {
        return self.personDetailPresenterMode
    }

    func getTitleRightButton() -> String {
        return self.personDetailPresenterMode.getTitleRightButton()
    }

    // MARK: - Navigation bar buttons
    func getTitleLeftButton() -> String {
        return self.personDetailPresenterMode.getTitleLeftButton()
    }

    func isEnabledRightButtton() -> Bool {
        guard personDetailPresenterMode.isEdit() else {
            return self.attributeUpdated.existsAttributesUpdated()
        }
        
        return true
    }

    func onRightButtonAction() {
        switch personDetailPresenterMode {
        case .edit:
            personDetailPresenterMode = .save
             self.onStateChanged(.save(self.person))
        case .save:
            personDetailPresenterMode = .edit
            self.onStateChanged(.busy)
            self.onUpdateAction(onComplete: {[weak self] updatedPerson in
                guard let weakSelf = self else { return }
                weakSelf.person = updatedPerson
                weakSelf.attributeUpdated = PersonDetailAttributesUpdated()
                weakSelf.onStateChanged(.editing(updatedPerson))
            })
        }
    }

    func onLeftButtonAction() {

        switch personDetailPresenterMode {
        case .edit: self.onStateChanged(.back)//self.onDismiss()
               return
        case .save:
            personDetailPresenterMode = .edit
            self.attributeUpdated = PersonDetailAttributesUpdated()
             self.onStateChanged(.editing(self.person))
        }
    }

    // MARK: - Delete person
    func delete() {
        self.onStateChanged(.busy)
        injectedPeopleUseCase.remove(person:person, onComplete: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.onStateChanged(.back)
        })
    }

    // MARK: - Private internal
    private func onUpdateAction(onComplete: (Person) -> Void) {

        let newPerson = Person(email: self.attributeUpdated.newEmail ?? self.person.email,
                               first: self.attributeUpdated.newFirst ?? self.person.first,
                               latitude: self.person.latitude,
                               longitude: self.person.longitude,
                               thumbnail: self.person.thumbnail,
                               large: self.person.large,
                               image: self.attributeUpdated.newImage ?? self.person.getImage())
        
        injectedPeopleUseCase.update(oldPerson: self.person, newPerson: newPerson, onComplete: onComplete)
    }

}
