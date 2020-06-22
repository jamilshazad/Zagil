//
//  ZATravelerFeedViewController.swift
//  Zagil
//
//  Created by Muhammad Khaliq ur Rehman on 21/04/2020.
//  Copyright © 2020 Muhammad Khaliq ur Rehman. All rights reserved.
//

import UIKit
import DateScrollPicker

class ZATravelerFeedViewController: ZAViewController {

    
    // MARK: - Class Properties
    
    @IBOutlet private weak var dateScrollPicker: DateScrollPicker!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    private var feeds: [SenderFeed] = []
    private var selectToday: Bool = true
    
    
    // MARK: - Life Cycle Methdos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if selectToday {
            dateScrollPicker.selectToday(animated: true)
            loadTravelerFeeds(for: Date())
            selectToday = false
        }
    }
    

    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationItem.title = "Trips Feed"
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "add"), for: .normal)
        button.addTarget(self, action:#selector(addButtonTapped(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItems = [barButton]
//        
//        let addButton = UIBarButtonItem(image: R.image.add(), style: .plain, target: self, action: #selector(addButtonTapped(_:)))
//        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupViewController() {
        customizeDatePicker()
        updateLabel(with: Date())
        setupTableView()
    }
    
    private func customizeDatePicker() {
        var format = DateScrollPickerFormat()
        format.days = 6
        format.topFont = UIFont.bold(fontSize: 12, font: .segoe)
        format.topTextColor = R.color.lightGrey()!
        format.mediumFont = UIFont.bold(fontSize: 23, font: .segoe)
        format.mediumTextColor = UIColor(hex: "#272727")
        format.bottomFont = UIFont.regular(fontSize: 12, font: .segoe)
        format.bottomTextColor = R.color.lightGrey()!
        format.dayRadius = 6
        format.dayBackgroundColor = UIColor(hex: "#EFEFEF")
        format.dayBackgroundSelectedColor = UIColor(hex: "#02AF76")
        format.animatedSelection = true
        format.separatorEnabled = true
        format.separatorTopDateFormat = "MMM"
        format.separatorTopFont = UIFont.bold(fontSize: 15, font: .segoe)
        format.separatorTopTextColor = UIColor(hex: "#272727")
        format.separatorBottomDateFormat = "yyyy"
        format.separatorBottomFont = UIFont.bold(fontSize: 15, font: .segoe)
        format.separatorBottomTextColor = UIColor(hex: "#272727")
        format.separatorBackgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        dateScrollPicker.format = format
        dateScrollPicker.delegate = self
    }
    
    private func updateLabel(with date: Date) {
        dateLabel.text = date.getString(of: .MMMM_dd)
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(types: ZADashboardTableViewCell.self)
    }
    
    private func updateTableView() {
        tableView.reloadData()
        if feeds.isEmpty {
            tableView.setEmptyBackgroundView(text: R.string.localizable.noResultMessage())
        } else {
            tableView.resetBackgroundView()
        }
    }
    
    private func loadTravelerFeeds(for date: Date) {
        showHud()
        APIClient.getTrips(date: date.getString(of: .dd_MM_YYYY)).done { [weak self] feeds in
            guard let self = self else { return }
            self.hideHud()
            self.feeds = feeds
            self.updateTableView()
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.hideHud()
            self.displayService(error: error)
        }
    }

}


// MARK: - Action Methods

extension ZATravelerFeedViewController {
    
    @objc
    private func addButtonTapped(_ sender: UIBarButtonItem) {
        push(viewController: ZAAddShipmentViewController.self, storyboard: R.storyboard.dashboard())
    }
    
}


// MARK: - DateScrollPicker Methods

extension ZATravelerFeedViewController: DateScrollPickerDelegate {
    
    func dateScrollPicker(_ dateScrollPicker: DateScrollPicker, didSelectDate date: Date) {
        updateLabel(with: date)
        loadTravelerFeeds(for: date)
    }
    
}


// MARK: - TableView Methods

extension ZATravelerFeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(type: ZADashboardTableViewCell.self) else { return UITableViewCell() }
        
        guard let feed = feeds[safe: indexPath.row] else { return UITableViewCell() }
        cell.configure(traveler: feed) { [weak self] in
            guard let _ = self else { return }
            // Contact Button Action
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
}
