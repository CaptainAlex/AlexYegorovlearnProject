//
//  Organization.h
//  TutorialApplication
//
//  Created by Александр Егоров on 1/16/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Employee.h"

@interface Organization : NSObject

@property(assign,nonatomic)int averageSalary;

@property(strong,nonatomic)NSString* name;


- (id)initWithName:(NSString*)name;

- (void)addEmployeeWithName:(NSString*)nameEmployee;

- (void)addEmployee:(Employee*)employ;

- (int)calculateAverageSalary;

- (NSString*)employeeWithLowestSalary;

- (NSArray*)employeesWithSalary:(int)salary tolerance:(int)tolerance;


@end
