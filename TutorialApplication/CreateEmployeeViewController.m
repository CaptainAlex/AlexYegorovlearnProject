//
//  CreateEmployeeViewController.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/25/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "CreateEmployeeViewController.h"
#import "Employee.h"
#import "DatabaseController.h"

@implementation CreateEmployeeViewController

- (IBAction)addNewEmployee
{
    NSString *firstName = self.firstNameTextField.text;
    NSString *lastName = self.lastNameTextField.text;
    NSString *salary = self.salaryTextField.text;
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    int salaryInt = [salary intValue];
    
    
    FFEmployee *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"FFEmployee" inManagedObjectContext:[DatabaseController sharedInstance].context];
    newEmployee.firstName = firstName;
    newEmployee.lastName = lastName;
    newEmployee.salary = salaryInt;
    newEmployee.fullName = fullName;
    
    [self.delegate onEmployeeCreated:newEmployee];
    
    NSLog(@"new object is created(delegate)");
    [self.navigationController popViewControllerAnimated:true];
}

@end
