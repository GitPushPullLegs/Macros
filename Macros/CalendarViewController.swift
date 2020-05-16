//
//  CalendarViewController.swift
//  Macros
//
//  Created by Jose Aguilar on 5/14/20.
//  Copyright © 2020 Jose Aguilar. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {

    lazy var calendarView: JTAppleCalendarView = {
        let calendarView = JTAppleCalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = .systemBackground
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        return calendarView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
    }

    private func setupCalendarView() {
        CalendarDateCell.register(calendarView)
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.leftAnchor.constraint(equalTo: view.leftAnchor),
            calendarView.rightAnchor.constraint(equalTo: view.rightAnchor),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! CalendarDateCell
        cell.dateLabel.text = cellState.text
    }

    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let startDate = formatter.date(from: "2020 01 01")!
        let endDate = formatter.date(from: "2020 06 06")!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate,
                                                 numberOfRows: 7, calendar: Calendar(identifier: .gregorian),
                                                 generateInDates: .forFirstMonthOnly, generateOutDates: .off,
                                                 firstDayOfWeek: .sunday, hasStrictBoundaries: false)
        return parameters
    }

    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = CalendarDateCell.dequeue(calendar, for: indexPath)
        cell.dateLabel.text = cellState.text
        cell.caloriesProgressView.setProgress(0.5, animated: false)
        cell.proteinProgressView.setProgress(0.31, animated: false)
        return cell
    }


}
