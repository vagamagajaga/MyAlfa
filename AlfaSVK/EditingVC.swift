//
//  EditingVC.swift
//  AlfaSVK
//
//  Created by Vagan Galstian on 04.05.2023.
//

import UIKit

final class EditingVC: UIViewController {
    
    private var addButton = UIButton()
    private var textField = UITextField()
    private var datePicker = UIDatePicker()
    
    private var bookStore = Store()
    var meetingViewController = MeetingVC()
    
    private var addButtonBottomConstraint: NSLayoutConstraint!
    
    private lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yy"
            return formatter
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
