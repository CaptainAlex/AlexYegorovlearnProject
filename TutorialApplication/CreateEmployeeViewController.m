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

@interface CreateEmployeeViewController() <HSDatePickerViewControllerDelegate>

@property (weak, nonatomic) NSDate *dateOfBirth;

@end

@implementation CreateEmployeeViewController 

-(void)hsDatePickerPickedDate:(NSDate *)date
{
    self.dateOfBirth = date;
    self.dateOfBirthTextField.text = [NSDateFormatter localizedStringFromDate:self.dateOfBirth dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    HSDatePickerViewController *hsdpvc = [HSDatePickerViewController new];
    
    [self presentViewController:hsdpvc animated:YES completion:nil];
    
    hsdpvc.delegate = self;
}

- (IBAction)addNewEmployee
{
    NSString *firstName = self.firstNameTextField.text;
    NSString *lastName = self.lastNameTextField.text;
    NSString *salary = self.salaryTextField.text;
    int salaryInt = [salary intValue];
    
    FFEmployee *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"FFEmployee" inManagedObjectContext:[DatabaseController sharedInstance].context];
    newEmployee.firstName = firstName;
    newEmployee.lastName = lastName;
    newEmployee.salary = salaryInt;
    newEmployee.dateOfBirth = self.dateOfBirth;
    
    [self.delegate onEmployeeCreated:newEmployee];
    
    NSLog(@"new object is created(delegate)");
    [self.navigationController popViewControllerAnimated:true];
}

@end
