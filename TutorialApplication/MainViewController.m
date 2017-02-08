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
#import "DatabaseController.h"

@interface MainViewController () <CreateEmployeeDelegate>

@property (strong, nonatomic) FFOrganization *organization;

@property (weak, nonatomic) FFEmployee *selectedEmployee;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.organization = [DatabaseController requestResultsForPredicate:nil sortDescriptors:nil entity:@"FFOrganization"].firstObject;
    
    if (!self.organization)
    {
        self.organization = [NSEntityDescription insertNewObjectForEntityForName:@"FFOrganization" inManagedObjectContext:[DatabaseController sharedInstance].context];
        self.organization.name = @"Best";
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        FFEmployee *newEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"FFEmployee" inManagedObjectContext:[DatabaseController sharedInstance].context];
        newEmployee.firstName = @"Eva";
        newEmployee.lastName = @"Green";
        newEmployee.salary = 15600;
        newEmployee.dateOfBirth = [dateFormatter dateFromString:@"1986-04-13"];
        
        [self.organization addEmployeesObject:newEmployee];
        
        [self.organization addEmployeeWithName:@"Miss Smith"];

    }
    [DatabaseController saveContext];
    
    NSLog(@"Average salary in the organization = %@", [self.organization.employees valueForKeyPath:@"@avg.salary"]);
    
    NSLog(@"%@", [self.organization employeeWithLowestSalary]);

    NSLog(@"%@", self.organization.employees.allObjects);
    
    NSLog(@"Employees that match the condition: %@", [self.organization employeesWithSalary:15000 tolerance:5000]);
}

- (void)onEmployeeCreated:(FFEmployee *)employee
{
    NSLog(@"method employeeFromController was used");
    [self.organization addEmployeesObject:employee];
    
    [DatabaseController saveContext:[DatabaseController sharedInstance].context];
    [self.tableView reloadData];
}
#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.organization.employees.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployeeCell" forIndexPath:indexPath];
    
    FFEmployee *employee = self.organization.sortedEmployees[indexPath.row];
    
    cell.textLabel.text =employee.fullName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedEmployee = self.organization.sortedEmployees[indexPath.row];
    
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
    else if ([segue.identifier isEqualToString:@"createEmployee"])
    {
        CreateEmployeeViewController *createEmployeeViewController = segue.destinationViewController;
        createEmployeeViewController.delegate = self;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [DatabaseController sharedInstance].context;
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.organization removeEmployeesObject:self.organization.sortedEmployees[indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error])
        {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
