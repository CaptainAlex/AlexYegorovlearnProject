//
//  FFEmployee+CoreDataProperties.m
//  TutorialApplication
//
//  Created by Александр Егоров on 1/31/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import "FFEmployee+CoreDataProperties.h"

@implementation FFEmployee (CoreDataProperties)

+ (NSFetchRequest<FFEmployee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FFEmployee"];
}

@dynamic firstName;
@dynamic fullName;
@dynamic lastName;
@dynamic salary;
@dynamic organization;


@end
