//
//  CreateEmployeeViewController.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/25/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "CreateEmployeeViewController.h"
#import "MainViewController.h"
#import "Employee.h"

@interface CreateEmployeeViewController ()

@end

@implementation CreateEmployeeViewController

- (IBAction)addNewEmployee:(id)sender
{
    NSString *str = [self.addFirstName text];
    NSString *str2 = [self.addLastName text];
    NSString *str3 = [self.addSalary text];
    int salary = [str3 intValue];
    
    self.employee = [[Employee alloc] initWithName:str lastName:str2 salary:salary];
    
    if ([self.delegate respondsToSelector:@selector(employeeFromController:)])
    {
        [self.delegate employeeFromController:self.employee];
    }
    NSLog(@"new object is created(delegate)");
    [self.navigationController popViewControllerAnimated:true];
}

@end
