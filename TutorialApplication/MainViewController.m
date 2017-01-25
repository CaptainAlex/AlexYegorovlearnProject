//
//  MainViewController.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/20/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "MainViewController.h"
#import "Employee.h"
#import "Organization.h"
#import "DetailViewController.h"
#import "CreateEmployeeViewController.h"

@interface MainViewController () <CreateEmployeeViewControllerDelegate>

@property (strong, nonatomic) Organization *organization;
@property (weak, nonatomic) Employee *selectedEmployee;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Employee *emp1 = [[Employee alloc] initWithName:@"Stepka" lastName:@"Pupkin" salary:3000];
    
    self.organization = [[Organization alloc] initWithName:@"TheBestOrganization"];
    
    [self.organization addEmployee:emp1];
    [self.organization addEmployeeWithName:@"Alex Yegorov"];
    [self.organization addEmployeeWithName:@"Vova Kynovskiy"];
    [self.organization addEmployeeWithName:@"Misha Davidayn"];
    
    NSLog(@"%lu employees in the organization", self.organization.employees.count);
    
    NSLog(@"Average salary in the organization = %d", [self.organization calculateAverageSalary]);
    
    NSLog(@"%@", [self.organization employeeWithLowestSalary]);
    
    NSLog(@"Employees that match the condition: %@", [self.organization employeesWithSalary:2000 tolerance:1000]);
    
    [self.organization removeEmployee:emp1];
    
    NSLog(@"%lu employees in the organization", self.organization.employees.count);
}

-(void)employeeFromController:(Employee *)employee
{
    NSLog(@"method employeeFromController was used");
    [self.organization addEmployee:employee];
    [self.tableView reloadData];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.organization.employees count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployeeCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.organization.employees[indexPath.row].firstName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedEmployee = self.organization.employees[indexPath.row];
    
    [self performSegueWithIdentifier:@"showDetail" sender:self];
    
    NSLog(@"Selected Name in Did select: %@", self.selectedEmployee.firstName);
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"])
    {
        DetailViewController *vc = segue.destinationViewController;
        vc.employee= self.selectedEmployee;
    }
    if ([segue.identifier isEqualToString:@"createEmployee"])
    {
        CreateEmployeeViewController *createEmployeeViewController = segue.destinationViewController;
        [createEmployeeViewController setDelegate:self];
    }
}

@end
