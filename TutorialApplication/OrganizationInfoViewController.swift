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
    var organization : FFOrganization!
    
    static let kEmployeesOrderHasChanged = "EmployeesOrderHasChanged"
    
    static let kOrganizationHasChanged = "OrganizationHasChanged"
    
    @IBAction func fetchOrganizations()
    {
        RequestManager.fetchOrganizations { (response) in
        
        DatabaseController.removeAllObjects(ofEntity: "FFOrganization")
    
        let organizations = response["organizations"] as? [[String : AnyObject]]
                
        OrganizationInfoViewController .create(fromJSON: organizations!)

        self.presentActionSheet()
    }
}
    
    static func create(fromJSON json: [[String : AnyObject]])
    {
        var newOrganization : FFOrganization
        
        var newEmployee : FFEmployee
        
        for jsonObjects in json
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
                
                newEmployee.firstName = item["first_name"] as? String ?? ""
                newEmployee.lastName = item["last_name"] as? String ?? ""
                newEmployee.order = item["order"] as! Int16
                
                if item["salary"] != nil && !(item["salary"] is NSNull)
                {
                    newEmployee.salary = item["salary"] as! Int32
                }
                
                newEmployee.isActive = item["isActive"] as! Bool
                newEmployee.dateOfBirth = dateFormatter.date(from:"1986/03/15")
                newOrganization.addEmployeesObject(newEmployee)
            }
            DatabaseController.saveContext()
        }
    }
    
    func presentActionSheet()
    {
        let actionSheetController = UIAlertController(title: "Please select organization", message: "", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheetController.addAction(cancelActionButton)
        
        let organizationsFromDB = DatabaseController.requestResults(for: nil, sortDescriptors: nil, entity: "FFOrganization")
        
        for organizations in 0...Int((organizationsFromDB!.count)) - 1
        {
            let organizationsList = UIAlertAction(title: (organizationsFromDB?[organizations] as! FFOrganization).name, style: .default){ action -> Void in
                
                let pickedOrganization = organizationsFromDB?[organizations] as! FFOrganization
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: OrganizationInfoViewController.kOrganizationHasChanged), object: self, userInfo: ["organization" : pickedOrganization])
                
                weak var weakSelf = self
                weakSelf!.navigationController!.popViewController(animated: true)
            }
            actionSheetController.addAction(organizationsList)
        }
        self.present(actionSheetController, animated: true, completion: nil)
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
