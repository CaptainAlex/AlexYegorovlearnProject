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
    
    let kEmployeesOrderHasChanged:String = "employeesOrderHasChanged"
    
    @IBAction func onRandomizeOrder()
    {
        var  countOrderNumbers = [Int]()
        
        for count in 1...self.organization.employees!.count
        {
            countOrderNumbers.append(count)
        }
        
        var employees = self.organization.sortedEmployees!
        
        let countEmployees = self.organization.employees!.count

        while countOrderNumbers.count > 0
        {
            let random = Int(arc4random_uniform(UInt32(countEmployees+1)))
            
                for i in 0...employees.count
                {
                    if let index = countOrderNumbers.index(of: random)
                    {
                        if( i != index)
                        {
                        swap(&employees[i], &employees[index])
                        countOrderNumbers.remove(at: index)
                        }
                }
            }
        }
        for (index, employee) in employees.enumerated()
        {
            employee.order = index + 1
        }
        DatabaseController.saveContext()
        NotificationCenter.default.post(name: Notification.Name(rawValue: kEmployeesOrderHasChanged), object: self)
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
