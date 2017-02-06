//
//  Organization.h
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/16/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FFOrganization+CoreDataClass.h"
#import "FFOrganization+CoreDataProperties.h"
@class FFEmployee;

@interface FFOrganization (Organization)

- (void)addEmployeeWithName:(NSString *)nameEmployee;

- (NSString *)employeeWithLowestSalary;

- (NSArray *)employeesWithSalary:(int)salary tolerance:(int)tolerance;

@end

