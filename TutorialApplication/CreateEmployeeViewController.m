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
#import "HSDatePickerViewController.h"

@interface CreateEmployeeViewController()<HSDatePickerViewControllerDelegate>

@end

@implementation CreateEmployeeViewController 

-(void)hsDatePickerPickedDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateOfBirthTextField.text = [dateFormatter stringFromDate:date];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    HSDatePickerViewController *hsdpvc = [[HSDatePickerViewController alloc]init];
    
    [self presentViewController:hsdpvc animated:YES completion:nil];
    
    hsdpvc.delegate = self;
    
    return YES;
}

- (IBAction)addNewEmployee
{
    NSString *firstName = self.firstNameTextField.text;
    NSString *lastName = self.lastNameTextField.text;
    NSString *salary = self.salaryTextField.text;
    int salaryInt = [salary intValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    FFEmployee *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"FFEmployee" inManagedObjectContext:[DatabaseController sharedInstance].context];
    newEmployee.firstName = firstName;
    newEmployee.lastName = lastName;
    newEmployee.salary = salaryInt;
    newEmployee.dateOfBirth = [dateFormatter dateFromString:self.dateOfBirthTextField.text];
    
    [self.delegate onEmployeeCreated:newEmployee];
    
    NSLog(@"new object is created(delegate)");
    [self.navigationController popViewControllerAnimated:true];
}

@end
