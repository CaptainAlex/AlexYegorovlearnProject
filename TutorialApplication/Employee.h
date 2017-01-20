//
//  Employee.h
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/16/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject


@property(assign,nonatomic)int salary;

@property(strong,nonatomic,readonly)NSString *fullName;

- (id) initWithName:(NSString *)firstName lastName:(NSString *)lastName salary:(int)salary;

@end
