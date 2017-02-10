//
//  DetailViewController.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/20/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "DetailViewController.h"
#import "Employee.h"
#import "FFEmployee+CoreDataClass.h"
#import "FFEmployee+CoreDataProperties.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.employee)
    {
        self.salaryLabel.text = [NSString stringWithFormat:@"%@'s salary is %d", self.employee.firstName, self.employee.salary];
        self.navigationItem.title = self.employee.fullName;
        self.dayOfBirthLabel.text = [NSString stringWithFormat:@"DateOfBirth: %@",[NSDateFormatter localizedStringFromDate:self.employee.dateOfBirth dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle]];
    }
}

@end
