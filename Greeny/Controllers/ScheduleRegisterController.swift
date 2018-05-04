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

class ScheduleRegisterController: UIViewController {
    
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarMenuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    
}
