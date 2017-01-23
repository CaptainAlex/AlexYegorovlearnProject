//
//  Employee.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/16/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "Employee.h"

@interface Employee()

@property(strong,nonatomic)NSString *firstName;
@property(strong,nonatomic)NSString *lastName;

@end

@implementation Employee


-(NSString *)firstName{
    
    return  _firstName;
}

-(NSString *)lastName{
    
    return _lastName;
}

- (id) initWithName: (NSString *)firstName lastName:(NSString *)lastName salary:(int)salary
{
    self = [super init];
    if(self)
    {
        self.firstName = firstName;
        self.lastName = lastName;
        self.salary = salary;

        _fullName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];

    }
    return self;
}

@end
