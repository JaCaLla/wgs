//
//  ImagePersonTVC.swift
//  wgs
//
//  Created by 08APO0516 on 07/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit

class ImagePersonTVC: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var imgPersonDetail: UIImageView!

    // MARK: - Callbacks
    var onImageUpdate: () -> Void = { /* Default empty block*/ }

    // MARK: - Private attributes
    private var person:Person?
    private var newImage:UIImage?
    private var personDetailPresenterMode:PersonDetailPresenterMode = .edit

    // MARK: - Lifecycle
    override func awakeFromNib() {
        self.setupView()
    }

    // MARK: - Public Helpers
    func set(person:Person?,
             newImage:UIImage?,
             personDetailPresenterMode:PersonDetailPresenterMode = .edit) {

        self.person = person
        self.newImage = newImage
        self.personDetailPresenterMode = personDetailPresenterMode
        self.refreshView()
    }

    // MARK: - Internal/Private
    private func setupView() {
        self.backgroundColor = AppColors.PersonDetail.background
        self.selectionStyle = .none
    }

    private func  refreshView() {

        guard let uwpPerson = self.person,
              let uwpImgPersonDetail = imgPersonDetail else { return }

        if let uwpImage = self.newImage {
             uwpImgPersonDetail.image = uwpImage
        } else if let uwpPerson = self.person,
            let uwpImage = uwpPerson.getImage() {
            uwpImgPersonDetail.image = uwpImage
        } else {
            uwpImgPersonDetail.sd_imageTransition = .fade
            uwpImgPersonDetail.sd_setShowActivityIndicatorView(true)
            uwpImgPersonDetail.sd_setIndicatorStyle(.gray)
            uwpImgPersonDetail.sd_setImage(with: uwpPerson.imageLargeURL(),
                                              placeholderImage: nil,
                                              options:.cacheMemoryOnly)
        }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgPersonDetail.isUserInteractionEnabled = true
        imgPersonDetail.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        guard personDetailPresenterMode.isSave() else { return }
        self.onImageUpdate()
    }
}
