//
//  PersonDetailPresenter.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit

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

class PersonDetailPresenter: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var personDetailView: PersonDetailView!
    var imagePicker = UIImagePickerController()


    // MARK: - Callbacks
    var onDismiss: () -> Void = { /* Default empty block */ }

    // MARK: - Private attributes
    private var person:Person = Person()
    private var personDetailPresenterMode:PersonDetailPresenterMode = .edit
    private let button = UIButton.init(type: .custom)

    private var attributeUpdated:PersonDetailAttributesUpdated = PersonDetailAttributesUpdated()

    // MARK: - Constructor/Initializer
    static func instantiate(person:Person) -> PersonDetailPresenter {
        let personDetailPresenter = PersonDetailPresenter.instantiate(fromAppStoryboard: .main)
        personDetailPresenter.person = person
        return personDetailPresenter
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPresenter(person: self.person)
        self.refreshPresenter()
    }

    // MARK: - Private methods
    private func setupPresenter(person:Person) {

        self.view.backgroundColor = AppColors.PersonDetail.Background

        personDetailView.person = person
        personDetailView.onFirstValueChanged = { [weak self] value in
            guard let weakSelf = self else { return }
            weakSelf.attributeUpdated.newFirst = value
            weakSelf.refreshPresenter()
        }
        personDetailView.onEmailValueChanged = {  [weak self] value in
            guard let weakSelf = self else { return }
            weakSelf.attributeUpdated.newEmail = value
            weakSelf.refreshPresenter()
        }
        personDetailView.onDeleteAction = { person in
            PeopleUseCase().remove(person:person, onComplete: { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.onDismiss()
            })
        }
        personDetailView.onImageUpdate = { [weak self]  in
            guard let weakSelf = self else { return }
            weakSelf.presentImagePicker()
        }

        personDetailView.personDetailPresenterMode = self.personDetailPresenterMode

        imagePicker.delegate = self
    }

    private func refreshPresenter() {

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: personDetailPresenterMode.getTitleRightButton(), style: .plain, target: self, action: #selector(onRightButtonAction))
        self.navigationItem.rightBarButtonItem?.isEnabled =  personDetailPresenterMode.isEdit() ? true : self.attributeUpdated.existsAttributesUpdated()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: personDetailPresenterMode.getTitleLeftButton(), style: .plain, target: self, action: #selector(onLeftButtonAction))

    }

    @objc func onRightButtonAction(sender: UIButton!) {
        // self.dismiss(animated: true, completion: nil)
        switch personDetailPresenterMode {
        case .edit:
            personDetailPresenterMode = .save
        case .save:
            personDetailPresenterMode = .edit
            self.onUpdateAction(onComplete: {[weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.onDismiss()
            })
        }
        if let upwPersonDetailView = self.personDetailView {
            upwPersonDetailView.personDetailPresenterMode = self.personDetailPresenterMode
        }
        self.refreshPresenter()
    }


    @objc func onLeftButtonAction(sender: UIButton!) {

        switch personDetailPresenterMode {
        case .edit: self.onDismiss()
        case .save:
            personDetailPresenterMode = .edit
            self.attributeUpdated = PersonDetailAttributesUpdated()
        }

        if let upwPersonDetailView = self.personDetailView {
            upwPersonDetailView.personDetailPresenterMode = self.personDetailPresenterMode
            upwPersonDetailView.attributeUpdated = self.attributeUpdated
        }
        self.refreshPresenter()
    }

    private func onUpdateAction(onComplete: (Person) -> Void) {

        let newPerson = Person(email: self.attributeUpdated.newEmail ?? self.person.email,
                               first: self.attributeUpdated.newFirst ?? self.person.first,
                               latitude: self.person.latitude,
                               longitude: self.person.longitude,
                               thumbnail: self.person.thumbnail,
                               large: self.person.large,
                               image: self.attributeUpdated.newImage ?? self.person.getImage())

        PeopleUseCase().update(oldPerson: self.person, newPerson: newPerson, onComplete: onComplete)
    }

    fileprivate func presentImagePicker() {
        let alert = UIAlertController(title: R.string.localizable.person_detail_picker_choose_image.key.localized, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: R.string.localizable.person_detail_picker_camera.key.localized, style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: R.string.localizable.person_detail_picker_gallery.key.localized, style: .default, handler: { _ in
            self.openGallary()
        }))

        alert.addAction(UIAlertAction.init(title: R.string.localizable.person_detail_picker_camera.key.localized, style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func openCamera()
    {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: R.string.localizable.person_detail_picker_warning_image.key.localized, message: R.string.localizable.person_detail_picker_no_camera_image.key.localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.localizable.person_detail_picker_ok_image.key.localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}


extension PersonDetailPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage{
            self.attributeUpdated.newImage = chosenImage
            self.personDetailView.attributeUpdated = attributeUpdated
            self.refreshPresenter()
            self.imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}
