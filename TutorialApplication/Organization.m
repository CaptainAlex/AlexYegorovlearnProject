//
//  Organization.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/16/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "Organization.h"
#import "Employee.h"
#import "MainViewController.h"
#import "DatabaseController.h"
#import "FFEmployee+CoreDataClass.h"
#import "FFOrganization+CoreDataClass.h"

@interface FFOrganization()

@end

@implementation FFOrganization (Organization)

- (void)addEmployeeWithName:(NSString *)nameEmployee
{
    NSString *stringName=nameEmployee;
    NSArray *items = [stringName componentsSeparatedByString:@" "];
    NSString *firstName=items[0];
    NSString *lastName=items[1];
    int ourSalary = ((arc4random_uniform(5000)+100)/100) * 100;
    
    FFEmployee *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"FFEmployee" inManagedObjectContext:[DatabaseController sharedInstance].context];
    newEmployee.firstName = firstName;
    newEmployee.lastName = lastName;
    newEmployee.salary = ourSalary;
    newEmployee.fullName = nameEmployee;
    
    NSLog(@"new employee is created");
    
    [self addEmployeesObject:newEmployee];
}

- (NSString *)employeeWithLowestSalary
{
    FFEmployee *empl = nil;
    
    int minSalary = 5000;
    for (FFEmployee *obj in self.employees)
    {
        if (obj.salary < minSalary)
        {
            minSalary = obj.salary;
            empl = obj;
        }
    }
    
    NSString *finalResult = [NSString stringWithFormat:@"Employee with lowest salary is %@, salary = %d", empl.fullName, minSalary];

    return finalResult;
}

- (NSArray *)employeesWithSalary:(int)salary tolerance:(int)tolerance
{
    int inputSalary = salary;
    int inputTolerance = tolerance;
    int min = inputSalary - inputTolerance;
    int max = inputSalary + inputTolerance;
    
    NSMutableArray *arrayEmployees = [NSMutableArray new];
    
    for(FFEmployee *obj in self.employees)
    {
        if (obj.salary >= min && obj.salary <= max)
        {
            [arrayEmployees addObject:obj.fullName];
        }
    }
    
    NSArray *finalArray = [[NSArray alloc]initWithArray:arrayEmployees];
    
    return  finalArray;
}

@end
