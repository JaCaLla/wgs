//
//  PersonDetailPresenter.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit

class PersonDetailPresenter: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var personDetailView: PersonDetailView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Callbacks
    var onDismiss: () -> Void = { /* Default empty block */ }

    private let button = UIButton.init(type: .custom)
    private var imagePicker = UIImagePickerController()
    private var injectedViewModel:PersonDetailViewModel = PersonDetailViewModel(person: Person())

    // MARK: - Constructor/Initializer
    static func instantiate(personDetailViewModel:PersonDetailViewModel) -> PersonDetailPresenter {
        let personDetailPresenter = PersonDetailPresenter.instantiate(fromAppStoryboard: .main)
       // personDetailPresenter.person = person
        personDetailPresenter.injectedViewModel = personDetailViewModel
        return personDetailPresenter
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPresenter()//(person: self.person)
        self.refreshNavigationBarButtons()
    }

    // MARK: - Private methods
    private func setupPresenter() {  //(person:Person) {

        self.title = R.string.localizable.person_list_detail.key.localized
        self.view.backgroundColor = AppColors.PersonDetail.Background

        activityIndicator.style = .whiteLarge
        activityIndicator.isHidden = true

        injectedViewModel.onStateChanged = { [weak self] personDetailViewModelState in
            guard let weakSelf = self else { return }
            weakSelf.refreshView(personDetailViewModelState: personDetailViewModelState)
        }

        personDetailView.person = injectedViewModel.getPerson()
        personDetailView.onFirstValueChanged = { [weak self] value in
            guard let weakSelf = self else { return }
            //weakSelf.attributeUpdated.newFirst = value
            weakSelf.injectedViewModel.set(newFirst: value)
            weakSelf.refreshNavigationBarButtons()
        }
        personDetailView.onEmailValueChanged = {  [weak self] value in
            guard let weakSelf = self else { return }
            //weakSelf.attributeUpdated.newEmail = value
            weakSelf.injectedViewModel.set(newEmail: value)
            weakSelf.refreshNavigationBarButtons()
        }
        personDetailView.onDeleteAction = { [weak self] in
             guard let weakSelf = self else { return }
            weakSelf.injectedViewModel.delete()
        }
        personDetailView.onImageUpdate = { [weak self]  in
            guard let weakSelf = self else { return }
            weakSelf.presentImagePicker()
        }

        personDetailView.personDetailPresenterMode = self.injectedViewModel.getPersonDetailPresenterMode()//self.personDetailPresenterMode

        imagePicker.delegate = self
    }

    private func refreshNavigationBarButtons() {

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: self.injectedViewModel.getTitleRightButton(), style: .plain, target: self, action: #selector(onRightButtonAction))
        self.navigationItem.rightBarButtonItem?.isEnabled = self.injectedViewModel.isEnabledRightButtton()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: self.injectedViewModel.getTitleLeftButton(), style: .plain, target: self, action: #selector(onLeftButtonAction))

    }

    func refreshView(personDetailViewModelState:PersonDetailViewModelState) {
        switch personDetailViewModelState {
        case .busy: self.refreshBusyStateView()
        case .deleted: self.refreshDeletedStateView()
        case .editing( let person): self.refreshEditingStateView(person: person)
        case .save(let person): self.refreshSaveStateView(person: person)
        case .back: self.onDismiss()
        }
    }

    func refreshBusyStateView() {
        self.refreshNavigationBarButtons()
        self.activityIndicator.isHidden = false
    }

    func refreshDeletedStateView() {
        self.refreshNavigationBarButtons()
        self.activityIndicator.isHidden = true
    }

    func refreshEditingStateView(person:Person) {
        self.refreshNavigationBarButtons()
        self.activityIndicator.isHidden = true

        if let upwPersonDetailView = self.personDetailView {
            upwPersonDetailView.personDetailPresenterMode = injectedViewModel.getPersonDetailPresenterMode()//self.personDetailPresenterMode
            upwPersonDetailView.person = injectedViewModel.getPerson()
            upwPersonDetailView.attributeUpdated = injectedViewModel.getPersonDetailAttributesUpdated()
        }
    }

    func refreshSaveStateView(person:Person) {
        self.refreshNavigationBarButtons()
        self.activityIndicator.isHidden = true

        if let upwPersonDetailView = self.personDetailView {
            upwPersonDetailView.personDetailPresenterMode = injectedViewModel.getPersonDetailPresenterMode()//self.personDetailPresenterMode
        }
    }

    @objc func onRightButtonAction(sender: UIButton!) {
        self.injectedViewModel.onRightButtonAction()
    }

    @objc func onLeftButtonAction(sender: UIButton!) {
        self.injectedViewModel.onLeftButtonAction()
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

    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: R.string.localizable.person_detail_picker_warning_image.key.localized, message: R.string.localizable.person_detail_picker_no_camera_image.key.localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.localizable.person_detail_picker_ok_image.key.localized, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallary() {
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
           // self.attributeUpdated.newImage = chosenImage
            self.injectedViewModel.set(newImage:chosenImage)
            //self.personDetailView.attributeUpdated = attributeUpdated
            self.personDetailView.attributeUpdated = self.injectedViewModel.getPersonDetailAttributesUpdated()
           // self.refreshPresenter()
            self.imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}
