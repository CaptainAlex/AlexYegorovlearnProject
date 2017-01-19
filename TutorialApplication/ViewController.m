//
//  ViewController.m
//  TutorialApplication
//
//  Created by Александр Егоров on 1/16/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setTitleLabel:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert" message:@"Enter" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* actionAddText = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField* textField = alert.textFields.firstObject;
        [self.myTitleLabel setText:textField.text];
    }];
    
    UIAlertAction* actionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:actionAddText];
    [alert addAction:actionCancel];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
