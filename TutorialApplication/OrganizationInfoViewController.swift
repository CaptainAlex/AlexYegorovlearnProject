//
//  OrganizationInfoViewController.swift
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 2/10/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

import UIKit

@objc class OrganizationInfoViewController: UIViewController
{
    var organization: FFOrganization!
    
    static let kEmployeesOrderHasChanged = "EmployeesOrderHasChanged"
    
    @IBAction func onRandomizeOrder()
    {
        var employees = self.organization.sortedEmployees!
        
        for i in 0...employees.count - 1
        {
            let k = Int(arc4random_uniform(UInt32(employees.count)))
            if i != k
            {
                swap(&employees[i], &employees[k])
            }
        }
        
        for (index, employee) in employees.enumerated()
        {
            employee.order = index + 1
        }
        DatabaseController.saveContext()
        NotificationCenter.default.post(name: Notification.Name(rawValue: OrganizationInfoViewController.kEmployeesOrderHasChanged), object: self)
    }
    
    @IBAction func onSalarySum()
    {
        var salarySum = 0
        
        for employeesSalary in self.organization.employees!
        {
            salarySum += Int(employeesSalary.salary)
        }

        let alertController = UIAlertController(title: "Sum of salaries", message: "the total sum of all salaries = \(salarySum)", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
