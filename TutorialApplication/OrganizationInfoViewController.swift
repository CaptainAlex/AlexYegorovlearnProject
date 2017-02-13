//
//  OrganizationInfoViewController.swift
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 2/10/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

import UIKit

class OrganizationInfoViewController: UIViewController {

    var organization: FFOrganization!

    @IBAction func salarySumOffAllEmployees()
    {
        var salarySum = 0
        
        for obj in organization.employees!
        {
            let int16: Int16 = obj.salary
            let objSalary: Int = Int(int16)
            salarySum += objSalary
        }

        let alertController = UIAlertController(title: "sum of salaries", message: String(salarySum), preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
