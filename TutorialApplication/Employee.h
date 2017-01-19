//
//  Employee.h
//  TutorialApplication
//
//  Created by Александр Егоров on 1/16/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject


@property(assign,nonatomic)int salary;

@property(strong,nonatomic,readonly)NSString* fullName;


- (id) initWithName:(NSString*)firstName LastName:(NSString*)lastName Salary:(int)salary;


@end
