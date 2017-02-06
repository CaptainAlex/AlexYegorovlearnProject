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
#import "AppDelegate.h"

@interface MainViewController () <CreateEmployeeDelegate>

@property (strong, nonatomic) FFOrganization *organization;

@property (strong, nonatomic) NSArray<FFEmployee*> *myEmployees;

@property (weak, nonatomic) FFEmployee *selectedEmployee;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.organization = [DatabaseController requestResultsForPredicate:nil sortDescriptors:nil entity:@"FFOrganization"].firstObject;
    
    if (self.organization == nil)
    {
        self.organization = [NSEntityDescription insertNewObjectForEntityForName:@"FFOrganization" inManagedObjectContext:[DatabaseController sharedInstance].context];
        self.organization.name = @"Best";
        
        FFEmployee *entityNameObj = [NSEntityDescription insertNewObjectForEntityForName:@"FFEmployee" inManagedObjectContext:[DatabaseController sharedInstance].context];
        entityNameObj.firstName = @"Eva";
        entityNameObj.lastName = @"Green";
        entityNameObj.salary = 15600;
        entityNameObj.fullName = @"Eva Green";
        
        [self.organization addEmployeesObject:entityNameObj];
        
        [self.organization addEmployeesObject:[self.organization addEmployeeWithName:@"Miss Smith"]];

    }
    
    [DatabaseController saveContext:[DatabaseController sharedInstance].context];
    
    self.myEmployees = [DatabaseController requestResultsForPredicate:nil sortDescriptors:nil entity:@"FFEmployee"];
    
    NSNumber *averageSalary = [self.myEmployees valueForKeyPath:@"@avg.salary"];
    
    NSLog(@"Average salary in the organization = %@", averageSalary);
    
    NSLog(@"%@", [self.organization employeeWithLowestSalary:self.myEmployees]);
    
    NSLog(@"Employees that match the condition: %@", [self.organization employeesWithSalary:15000 tolerance:1000 employess:self.myEmployees]);

}

- (void)onEmployeeCreated:(FFEmployee *)employee
{
    NSLog(@"method employeeFromController was used");
    [self.organization addEmployeesObject:employee];
    
    [DatabaseController saveContext:[DatabaseController sharedInstance].context];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.myEmployees = [DatabaseController requestResultsForPredicate:nil sortDescriptors:nil entity:@"FFEmployee"];
    [self.tableView reloadData];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.myEmployees count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmployeeCell" forIndexPath:indexPath];
    
    NSManagedObject *employee = self.myEmployees [indexPath.row];
    
    cell.textLabel.text = [employee valueForKey:@"fullName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedEmployee = self.myEmployees [indexPath.row];
    
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
    
        NSMutableArray *arrayEmployees = [NSMutableArray new];
        arrayEmployees = [self.myEmployees mutableCopy];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete object from database
        [context deleteObject:[arrayEmployees objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error])
        {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        // Remove device from table view
        [arrayEmployees removeObjectAtIndex:indexPath.row];
        self.myEmployees = [arrayEmployees copy];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
