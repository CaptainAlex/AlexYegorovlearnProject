//
//  MainViewController.h
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/20/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreateEmployeeViewController;
@class Employee;
@class Organization;

@interface MainViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createNewEmployee;

@end
