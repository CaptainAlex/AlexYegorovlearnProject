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

@implementation FFOrganization (Organization)

- (FFEmployee*)addEmployeeWithName:(NSString *)nameEmployee
{
    NSString *stringName=nameEmployee;
    NSArray *items = [stringName componentsSeparatedByString:@" "];
    NSString *str1=items[0];
    NSString *str2=items[1];
    int ourSalary = ((arc4random_uniform(5000)+100)/100) * 100;
    
    FFEmployee *entityNameObj = [NSEntityDescription insertNewObjectForEntityForName:@"FFEmployee" inManagedObjectContext:[DatabaseController sharedInstance].context];
    entityNameObj.firstName = str1;
    entityNameObj.lastName = str2;
    entityNameObj.salary = ourSalary;
    entityNameObj.fullName = nameEmployee;
    
    NSLog(@"new employee is created");
    
    return entityNameObj;
}

- (NSString *)employeeWithLowestSalary:(NSArray*)myEmployees
{
    FFEmployee *empl = nil;
    
    int minSalary = 5000;
    for (FFEmployee *obj in myEmployees)
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

- (NSArray *)employeesWithSalary:(int)salary tolerance:(int)tolerance employess:(NSArray*)myEmployees
{
    int inputSalary = salary;
    int inputTolerance = tolerance;
    int min = inputSalary - inputTolerance;
    int max = inputSalary + inputTolerance;
    
    NSMutableArray *arrayEmployees = [NSMutableArray new];
    
    for(FFEmployee *obj in myEmployees)
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
