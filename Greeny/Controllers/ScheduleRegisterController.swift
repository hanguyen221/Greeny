//
//  ScheduleRegisterController.swift
//  Greeny
//
//  Created by Tung Nguyen on 5/4/18.
//  Copyright © 2018 Ha Nguyen. All rights reserved.
//

import Foundation
import UIKit
import CVCalendar

class ScheduleRegisterController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Đăng kí lịch nghỉ"
        
        calendarMenuView.dayOfWeekTextColor = .white
        calendarMenuView.dayofWeekBackgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarMenuView.commitMenuViewUpdate()
        
        calendarView.commitCalendarViewUpdate()
        calendarView.backgroundColor = .white
        
    }
    
    func presentationMode() -> CalendarMode {
        return CalendarMode.monthView
    }
    
    func firstWeekday() -> Weekday {
        return Weekday.monday
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    @IBAction func registerTapped(_ sender: UIButton) {
        let date = calendarView.presentedDate.convertedDate()
        let alert = UIAlertController(title: "Thông báo", message: "Đã đăng kí lịch nghỉ cho ngày \(dateFormatter.string(from: date!))", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}





