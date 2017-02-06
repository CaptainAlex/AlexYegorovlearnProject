//
//  DetailViewController.h
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/20/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFEmployee+CoreDataClass.h"

@class FFEmployee;

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;

@property (strong, nonatomic) FFEmployee *employee;

@end
