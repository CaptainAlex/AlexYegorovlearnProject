//
//  Organization.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/16/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "Organization.h"
#import "Employee.h"

@interface Organization()

@property (strong, nonatomic) NSArray<Employee *> *employees;

@property (assign, nonatomic) int countForSalary;

@end

@implementation Organization

- (id)initWithName:(NSString *)name

{
    self = [super init];
    
    if (self)
    {
        self.name = name;
        self.employees = [[NSArray alloc]init];
    }
    return self;
}

- (void)addEmployeeWithName:(NSString *)nameEmployee
{
    NSString *stringName=nameEmployee;
    NSArray *items = [stringName componentsSeparatedByString:@" "];
    NSString *str1=[items objectAtIndex:0];
    NSString *str2=[items objectAtIndex:1];
    int ourSalary = ((arc4random_uniform(5000)+100)/100) * 100;
    Employee *emp = [[Employee alloc] initWithName:str1 lastName:str2 salary:ourSalary];
    NSLog(@"new employee is created");
    NSMutableArray *arrayEmployees = [NSMutableArray new];
    arrayEmployees = [self.employees mutableCopy];
    
    [arrayEmployees addObject:emp];
    
    self.employees = [arrayEmployees copy];
}

- (void)addEmployee:(Employee *)employee
{
    NSMutableArray *arrayEmployees = [NSMutableArray new];
    arrayEmployees = [self.employees mutableCopy];
    
    [arrayEmployees addObject:employee];
    
    self.employees = [arrayEmployees copy];
}

- (void)removeEmployee:(Employee *)employee
{
    NSMutableArray *arrayEmployees = [NSMutableArray new];
    arrayEmployees = [self.employees mutableCopy];
    
    [arrayEmployees removeObject:employee];
    
    self.employees = [arrayEmployees copy];
}

- (int)calculateAverageSalary
{
    int midSalary = 0;

    for (Employee *obj in self.employees)
    {

        midSalary = midSalary + obj.salary;
    }
    
    midSalary = midSalary/[self.employees count];
    
    return midSalary;
}

- (NSString *)employeeWithLowestSalary
{
    Employee *empl = nil;
    
    int minSalary = 5000;
    for (Employee *obj in self.employees)
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
    
    for(Employee *obj in self.employees)
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
