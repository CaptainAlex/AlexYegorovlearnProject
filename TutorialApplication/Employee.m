//
//  Employee.m
//  TutorialApplication
//
//  Created by Александр Егоров on 1/16/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import "Employee.h"

@interface Employee()

@property(strong,nonatomic)NSString *firstName;
@property(strong,nonatomic)NSString *lastName;

@end

@implementation Employee

- (instancetype) initWithName: (NSString *)firstName LastName:(NSString*)lastName Salary:(int)salary
{
    self = [super init];
    if(self)
    {
        self.firstName = firstName;
        self.lastName = lastName;
        self.salary = salary;
        _fullName = [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
    }
    return self;
}

@end
