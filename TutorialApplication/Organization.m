//
//  Organization.m
//  TutorialApplication
//
//  Created by Александр Егоров on 1/16/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import "Organization.h"
@interface Organization()

@property(strong,nonatomic) NSArray<Employee *>* employeers;
@property(assign,nonatomic)int countForSalary;

@end

@implementation Organization

- (id)initWithName:(NSString*)name
{
    self = [super init];
    
    if(self)
    {
        self.name = name;
        self.employeers = [[NSArray alloc]init];
    }
    return self;
}

- (int)getRandomNumberBetween
{
    int fromNumber = 100;
    int toNumber = 5000;
    int randomNumber = 1;
   
    while (randomNumber % 10 != 0)
    {
        randomNumber = (arc4random()%(toNumber-fromNumber))+fromNumber;
        
    }
    return randomNumber;
}


- (void)addEmployeeWithName:(NSString*)nameEmployee
{
    int ourSalary = [self getRandomNumberBetween];
    Employee* emp = [[Employee alloc]initWithName:nameEmployee LastName:@"test" Salary:ourSalary];
    NSLog(@"new employee is created");
    
    self.countForSalary++;
    self.averageSalary += emp.salary;

    NSMutableArray *array = [NSMutableArray new];
    array = [self.employeers mutableCopy];

    [array addObject:emp];
    
    self.employeers = [array copy];
}

- (void)addEmployee:(Employee*)employee
{
    NSMutableArray *array = [NSMutableArray new];
    array = [self.employeers mutableCopy];
    
    [array addObject:employee];
    
    self.employeers = [array copy];
}

- (void)removeEmployee:(Employee *)employee
{
    NSMutableArray *array = [NSMutableArray new];
    array = [self.employeers mutableCopy];
    
    [array removeObject:employee];
    
    self.employeers = [array copy];
}

- (void)print
{
    NSLog(@"%lu employees in the organization",(unsigned long)[_employeers count]);
}



- (int)calculateAverageSalary
{
    return self.averageSalary/_countForSalary;
}


- (NSString*)employeeWithLowestSalary
{
    Employee *empl = nil;
    
    int minSalary = 5000;
    for (Employee* obj in self.employeers)
    {
        if(obj.salary < minSalary)
        {
            minSalary = obj.salary;
            empl = obj;
        }
    }
    
    NSString* finalResult = [NSString stringWithFormat:@"Employee with lowest salary is %@, salary = %d",empl.fullName,minSalary];
    
    return finalResult;
}

- (NSArray*)employeesWithSalary:(int)salary tolerance:(int)tolerance
{
    int inputSalary = salary;
    int inputTolerance = tolerance;
    int min = inputSalary - inputTolerance;
    int max = inputSalary + inputTolerance;
    
     NSMutableArray *array = [NSMutableArray new];
    
    for(Employee* obj in self.employeers)
    {
        if(obj.salary > min && obj.salary < max)
        {
            
            [array addObject:obj.fullName];
        }
    }
    
    NSArray *finalArray = [[NSArray alloc]initWithArray:array];
    
    return  finalArray;
}

@end
