//
//  FFEmployee+CoreDataProperties.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 2/8/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "FFEmployee+CoreDataProperties.h"

@implementation FFEmployee (CoreDataProperties)

+ (NSFetchRequest<FFEmployee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FFEmployee"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic salary;
@dynamic dateOfBirth;
@dynamic organization;

@end
