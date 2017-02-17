//
//  FFEmployee+CoreDataProperties.m
//  TutorialApplication
//
//  Created by Александр Егоров on 2/14/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import "FFEmployee+CoreDataProperties.h"

@implementation FFEmployee (CoreDataProperties)

+ (NSFetchRequest<FFEmployee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FFEmployee"];
}

@dynamic dateOfBirth;
@dynamic firstName;
@dynamic lastName;
@dynamic salary;
@dynamic order;
@dynamic organization;

@end
