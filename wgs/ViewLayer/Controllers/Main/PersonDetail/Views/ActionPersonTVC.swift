//
//  ImagePersonTVC.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit

enum ActionPersonType {
    case delete
    func getText() -> String {
        switch self {
        case .delete: return R.string.localizable.person_detail_delete.key.localized
        }
    }
}

class ActionPersonTVC: UITableViewCell {

    @IBOutlet weak var btnAction: UIButton!

    
    // MARK: - Callbacks
    var onDeleteAction: () -> Void = { /* Default empty block */}

    // MARK: - Public attributes
    var actionPersonType:ActionPersonType = .delete {
    didSet{
        setupView()
    }
    }


    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    // MARK: - Internal/Private
    func setupView() {

        self.backgroundColor = AppColors.PersonDetail.background
        self.selectionStyle = .none

        btnAction.titleLabel?.font        = AppFonts.PersonDetail.buttonFont
        btnAction.titleLabel?.textColor   = AppColors.PersonDetail.fontColor
        btnAction.backgroundColor         = AppColors.PersonDetail.buttonBackgroundColor
        btnAction.setTitle(actionPersonType.getText(), for: .normal)
        btnAction.layer.cornerRadius = 5.0

        btnAction.addTarget(self, action: #selector(onActionButton), for: .touchUpInside)
    }

    // MARK: - Target methods
    @objc func onActionButton(sender: UIButton!) {
        switch actionPersonType {
        case .delete: self.onDeleteAction()
        }
    }
}
