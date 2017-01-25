//
//  CreateEmployeeViewController.h
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/25/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Employee;
@class MainViewController;

@protocol CreateEmployeeViewControllerDelegate <NSObject>

@required

- (void)employeeFromController:(Employee *)employee;

@end

@interface CreateEmployeeViewController : UIViewController

@property (nonatomic, strong) Employee *employee;

@property (nonatomic, weak) id<CreateEmployeeViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *addFirstName;

@property (weak, nonatomic) IBOutlet UITextField *addLastName;

@property (weak, nonatomic) IBOutlet UITextField *addSalary;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end
