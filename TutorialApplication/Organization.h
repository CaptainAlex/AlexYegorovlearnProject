//
//  Organization.h
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/16/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Employee;

@interface Organization : NSObject

@property (strong, nonatomic, readonly) NSArray<Employee *> *employeers;

@property (strong, nonatomic) NSString *name;

- (id)initWithName:(NSString *)name;

- (void)addEmployeeWithName:(NSString *)nameEmployee;

- (void)addEmployee:(Employee *)employee;

- (void)removeEmployee:(Employee *)employee;

- (int)calculateAverageSalary;

- (NSString *)employeeWithLowestSalary;

- (NSArray *)employeesWithSalary:(int)salary tolerance:(int)tolerance;

@end

