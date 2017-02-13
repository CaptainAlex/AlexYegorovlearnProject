//
//  OrganizationInfoViewController.swift
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 2/10/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

import UIKit

class OrganizationInfoViewController: UIViewController
{
    var organization: FFOrganization!

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
