//
//  CreateEmployeeViewController.h
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/25/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFEmployee;

@protocol CreateEmployeeDelegate

- (void)onEmployeeCreated:(FFEmployee *)employee;

@end

@interface CreateEmployeeViewController : UIViewController

@property (nonatomic, weak) id<CreateEmployeeDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *salaryTextField;

@end
