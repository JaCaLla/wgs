//
//  PeopleListTVC.swift
//  wgs
//
//  Created by 08APO0516 on 06/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit
import SDWebImage

class PeopleListTVC: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblEmail: UILabel!

    // MARK: - Public Attributes
    var person:Person? {
        didSet {
            guard let uwpPerson = person else { return }
            self.refreshView(person:uwpPerson)
        }
    }
    // MARk: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupView()
    }

    func setupView() {
        self.backgroundColor = AppColors.PersonsList.Background

        self.selectionStyle = .none

        lblFirst.font = AppFonts.PersonsList.FirstFont
        lblFirst.textColor = AppColors.PersonsList.FirstFontColor

        lblEmail.font = AppFonts.PersonsList.EmailFont
        lblEmail.textColor = AppColors.PersonsList.EmailFontColor
    }

    // MARK: - Private/Internal
    func refreshView(person:Person) {
        self.lblFirst?.text = person.first
        self.lblEmail?.text = person.email

        if let uwpImage = person.getImage() {
            self.imgThumbnail?.image = uwpImage
        } else {
            self.imgThumbnail?.sd_imageTransition = .fade
            self.imgThumbnail?.sd_setShowActivityIndicatorView(true)
            self.imgThumbnail?.sd_setIndicatorStyle(.gray)
            self.imgThumbnail?.sd_setImage(with: person.imageURL(),
                                              placeholderImage: nil,
                                              options:.cacheMemoryOnly)
        }
    }

}
