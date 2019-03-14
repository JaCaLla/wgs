//
//  PeopleListView.swift
//  wgs
//
//  Created by 08APO0516 on 06/03/2019.
//  Copyright © 2019 jca. All rights reserved.
//

import UIKit

class PeopleListView: UITableView {

    // MARK: - Callbacks
    var onRequestForMore: () -> Void = { /* Default empty block */}
    var onPersonSelected: (Person) -> Void = { _ in /* Default empty block*/}

    // MARK: - Public attributes
    var people:[Person] = [] {
        didSet{
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

      self.backgroundColor = AppColors.PersonsList.background

      self.dataSource         =  self
      self.delegate           = self
    }

    private func  refreshView() {

        self.reloadData()
    }
}

extension PeopleListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onPersonSelected(self.people[indexPath.row])
    }
}

extension PeopleListView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let peopleListTVC:PeopleListTVC = self.dequeueReusableCell(withIdentifier: R.reuseIdentifier.peopleListTVC, for: indexPath) else {
            return UITableViewCell()
        }

        peopleListTVC.person = self.people[indexPath.row]
        if indexPath.row == self.people.count - 1 {
            self.onRequestForMore()
        }
        return peopleListTVC
    }
}
