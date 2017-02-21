//
//  FFEmployee+CoreDataProperties.m
//  TutorialApplication
//
//  Created by Александр Егоров on 2/21/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import "FFEmployee+CoreDataProperties.h"

@implementation FFEmployee (CoreDataProperties)

+ (NSFetchRequest<FFEmployee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FFEmployee"];
}

@dynamic dateOfBirth;
@dynamic firstName;
@dynamic isActive;
@dynamic lastName;
@dynamic order;
@dynamic salary;
@dynamic organization;

@end
