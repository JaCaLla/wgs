//
//  ImagePersonTVC.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit

enum AttributePersonType {
    case first(Person)
    case email(Person)

    func getText() -> String {
        switch self {
        case .first( _ ): return R.string.localizable.person_detail_first.key.localized
         case .email( _ ): return R.string.localizable.person_detail_email.key.localized
        }
    }

    func getValue() -> String {
        switch self {
        case .first( let person ): return person.first
        case .email( let person ): return person.email
        }
    }

    func onValueChanged(attributePersonTVC: AttributePersonTVC, value:String) {
        switch self {
        case .first( _ ): attributePersonTVC.onFirstValueChanged(value)
        case .email( _ ): attributePersonTVC.onEmailValueChanged(value)
        }
    }
}

class AttributePersonTVC: UITableViewCell {

    // MARKK : - IBOutlets
    @IBOutlet weak var txtAttributeValue: UITextField!
    @IBOutlet weak var lblAttributeName: UILabel!

    // MARK: - Callbacks
    var onEmailValueChanged: (String) -> Void = { _ in /* Default empty block*/}
    var onFirstValueChanged: (String) -> Void = { _ in /* Default empty block*/}

    private var attributePersonType:AttributePersonType = .first(Person())
    private var personDetailPresenterMode:PersonDetailPresenterMode = .edit

    func set(attributePersonType:AttributePersonType,
             personDetailPresenterMode:PersonDetailPresenterMode) {
        
        self.attributePersonType = attributePersonType
        self.personDetailPresenterMode = personDetailPresenterMode
        self.refreshView()
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()

    }

    // MARK: - Target methods
    @objc func textFieldDidChange(textField: UITextField){

        guard let text = textField.text else { return }
        textField.text = text
        attributePersonType.onValueChanged(attributePersonTVC: self, value: text)

    }

    //  MARK: - Private/Internal methods
    private func setupView() {
        backgroundColor = AppColors.PersonDetail.Background
        self.selectionStyle = .none
        txtAttributeValue.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }

    private func  refreshView() {
        lblAttributeName.font = AppFonts.PersonDetail.LabelFont
        lblAttributeName.textColor = AppColors.PersonDetail.FontColor
        lblAttributeName.text = attributePersonType.getText()

        txtAttributeValue.font = AppFonts.PersonDetail.ValueFont
        txtAttributeValue.text = attributePersonType.getValue()
        txtAttributeValue.delegate = self
        txtAttributeValue.borderStyle = personDetailPresenterMode.isSave() ? .line :  .none
        txtAttributeValue.textColor = AppColors.PersonDetail.FontColor//personDetailPresenterMode.isSave() ? AppColors.PersonDetail.Background : AppColors.PersonDetail.FontColor
    }
}

extension AttributePersonTVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       return personDetailPresenterMode.isSave()
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        guard let text = textField.text else { return false}
        attributePersonType.onValueChanged(attributePersonTVC: self, value: text)
        self.endEditing(true)
        return false
    }
}

