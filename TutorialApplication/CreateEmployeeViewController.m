//
//  CreateEmployeeViewController.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/25/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "CreateEmployeeViewController.h"
#import "Employee.h"

@interface CreateEmployeeViewController ()

@end

@implementation CreateEmployeeViewController

- (IBAction)addNewEmployee
{
    NSString *firstName = self.firstNameTextField.text;
    NSString *lastName = self.lastNameTextField.text;
    NSString *salary = self.salaryTextField.text;
    int salaryInt = [salary intValue];
    
    Employee *newEmp = [[Employee alloc] initWithName:firstName lastName:lastName salary:salaryInt];
    
        [self.delegate onEmployeeCreated:newEmp];
    
    NSLog(@"new object is created(delegate)");
    [self.navigationController popViewControllerAnimated:true];
}

@end
