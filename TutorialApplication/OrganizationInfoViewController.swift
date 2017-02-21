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
    
    static let kOrganizationHasChanged = "OrganizationHasChanged"
    
    @IBAction func fetchOrganizations()
    {
        RequestManager.fetchOrganizations { (response) in
        
        var newOrganization:FFOrganization
        
        var newEmployee:FFEmployee
            
        let countOfOrganizations = DatabaseController.requestResults(for: nil, sortDescriptors: nil, entity: "FFOrganization")
        print(countOfOrganizations?.count as Any)
        
        if (countOfOrganizations?.count)! <= 1
        {
        let organizations = response["organizations"]
        
        for jsonObjects in organizations as! [AnyObject]
            {
                let organizationName = jsonObjects["name"] as! String
                
                let organizationEmployees = jsonObjects["employees"] as! [[String : AnyObject]]
                
                print("org name = \(organizationName)  employess = \(organizationEmployees)")
                
                newOrganization = NSEntityDescription.insertNewObject(forEntityName: "FFOrganization", into: DatabaseController.sharedInstance().context) as! FFOrganization
                
                newOrganization.name = organizationName
                
                for item in organizationEmployees
                {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    newEmployee = NSEntityDescription.insertNewObject(forEntityName: "FFEmployee", into: DatabaseController.sharedInstance().context) as! FFEmployee

                    newEmployee.firstName = (item["first_name"] as! String)
                    newEmployee.lastName = (item["last_name"] as! String)
                    newEmployee.order = item["order"] as! Int16
                    
                    if item["salary"] != nil && !(item["salary"] is NSNull)
                    {
                        newEmployee.salary = item["salary"] as! Int32
                    }
                    
                    newEmployee.isActive = item["isActive"] as! Bool
                    newEmployee.dateOfBirth = dateFormatter.date(from:"1986-04-13")
                    newOrganization.addEmployeesObject(newEmployee)
                }
                 DatabaseController.saveContext()
            }
        }
            
            
        let actionSheetController = UIAlertController(title: "Please select organization", message: "", preferredStyle: .actionSheet)
            
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel)
        { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
            
            for organizations in 0...Int((countOfOrganizations?.count)!)-1
            {
                let organizationsList = UIAlertAction(title: (countOfOrganizations?[organizations] as! FFOrganization).name, style: .default)
                { action -> Void in
                    
                    let pickedOrganization = countOfOrganizations?[organizations] as! FFOrganization
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: OrganizationInfoViewController.kOrganizationHasChanged), object: self, userInfo: ["organization" : pickedOrganization])
                    
                    self.navigationController!.popViewController(animated: true)
                    
                    self.dismiss(animated: true, completion: nil)
                }
                actionSheetController.addAction(organizationsList)
            }
        self.present(actionSheetController, animated: true, completion: nil)
    }
}
    
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
