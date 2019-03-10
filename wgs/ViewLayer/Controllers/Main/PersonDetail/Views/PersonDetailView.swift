//
//  PesronDetailView.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit

enum PersonDetailViewOptions : Int {
    case userImage
    case first
    case email
    case location
    case deleteAction

    private static let allValuesEditMode = [userImage,first,email,location]
    private static let allValuesSaveMode = [userImage,first,email,location,deleteAction]

    static func count(personDetailPresenterMode:PersonDetailPresenterMode) -> Int {
        switch personDetailPresenterMode {
        case .edit: return PersonDetailViewOptions.allValuesEditMode.count
        case .save: return PersonDetailViewOptions.allValuesSaveMode.count
        }
    }

    static func get(personDetailPresenterMode:PersonDetailPresenterMode,index:Int) -> PersonDetailViewOptions? {
        switch personDetailPresenterMode {
        case .edit:
            guard index < PersonDetailViewOptions.allValuesEditMode.count else { return nil }
            return PersonDetailViewOptions.allValuesEditMode[index]
        case .save:
            guard index < PersonDetailViewOptions.allValuesSaveMode.count else { return nil }
            return PersonDetailViewOptions.allValuesSaveMode[index]
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, person:Person,personDetailView:PersonDetailView) -> UITableViewCell {
        switch  self {
        case .userImage:
            guard let imagePersonTVC:ImagePersonTVC =
                tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.imagePersonTVC.identifier) as? ImagePersonTVC else { return UITableViewCell() }
            imagePersonTVC.set(person: person, newImage: personDetailView.attributeUpdated.newImage, personDetailPresenterMode: personDetailView.personDetailPresenterMode)
            imagePersonTVC.onImageUpdate = personDetailView.onImageUpdate
            return imagePersonTVC
        case .first,.email:
            guard let attributePersonTVC:AttributePersonTVC =
                tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.attributePersonTVC.identifier) as? AttributePersonTVC,
                let attributePersonType = getAttributePersonType(person: person) else { return UITableViewCell() }
            attributePersonTVC.set(attributePersonType: attributePersonType,
                                   personDetailPresenterMode: personDetailView.personDetailPresenterMode)
            attributePersonTVC.onEmailValueChanged = personDetailView.onEmailValueChanged
            attributePersonTVC.onFirstValueChanged = personDetailView.onFirstValueChanged
            return attributePersonTVC
        case .location:
            guard let mapPersonTVC:MapPersonTVC = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mapPersonTVC.identifier) as? MapPersonTVC else { return UITableViewCell() }
            mapPersonTVC.person = person
            return mapPersonTVC
        case .deleteAction:
            guard let actionPersonTVC:ActionPersonTVC = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.actionPersonTVC.identifier) as? ActionPersonTVC else { return UITableViewCell() }
            actionPersonTVC.onDeleteAction = { 
                personDetailView.onDeleteAction(person)
            }
            return actionPersonTVC
        }
    }

    func getAttributePersonType(person:Person) -> AttributePersonType? {
        switch self {
        case .userImage, .location, .deleteAction: return nil
        case .first: return AttributePersonType.first(person)
        case .email: return AttributePersonType.email(person)
        }
    }
}

class PersonDetailView: UITableView {

    // MARK: - Callbacks
    var onEmailValueChanged: (String) -> Void = { _ in /* Default empty block*/}
    var onFirstValueChanged: (String) -> Void = { _ in /* Default empty block*/}
    var onDeleteAction: (Person) -> Void = { _ in /* Default empty block*/}
    var onImageUpdate: () -> Void = { /* Default empty block*/ }

    // MARK : - Public attributes
    var person:Person? {
        didSet {
            guard person != nil else { return }
            self.refreshView()
        }
    }
    var personDetailPresenterMode:PersonDetailPresenterMode = .edit {
        didSet {
            self.refreshView()
        }
    }
    
    var attributeUpdated:PersonDetailAttributesUpdated = PersonDetailAttributesUpdated() {
        didSet {
            self.refreshView()
        }
    }

    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    // MARK: - Internal/Private
    func setupView() {
        
        self.backgroundColor = AppColors.PersonDetail.Background
        self.dataSource         =  self
    }

    private func  refreshView() {

        self.reloadData()
    }
}

extension PersonDetailView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonDetailViewOptions.count(personDetailPresenterMode:self.personDetailPresenterMode)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let personDetailViewOptions = PersonDetailViewOptions.get(personDetailPresenterMode:self.personDetailPresenterMode,index:indexPath.row),
              let upwPerson = self.person else { return UITableViewCell() }

        return  personDetailViewOptions.tableView(tableView, cellForRowAt: indexPath, person: upwPerson,personDetailView:self)
    }
}

