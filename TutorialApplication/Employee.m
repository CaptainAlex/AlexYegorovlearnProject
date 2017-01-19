//
//  Employee.m
//  TutorialApplication
//
//  Created by Александр Егоров on 1/16/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import "Employee.h"

@interface Employee()

@property(strong,nonatomic)NSString* firstName;
@property(strong,nonatomic)NSString* lastName;

@end

@implementation Employee

- (instancetype) initWithName: (NSString*)firstNAME LastName:(NSString*)lastNAME Salary:(int)salarry
{
    self = [super init];
    if(self)
    {
        self.firstName = firstNAME;
        self.lastName = lastNAME;
        self.salary = salarry;
        _fullName = [NSString stringWithFormat:@"%@ %@",self.firstName,self.lastName];
    }
    return self;
}

@end
