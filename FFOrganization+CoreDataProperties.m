//
//  FFOrganization+CoreDataProperties.m
//  TutorialApplication
//
//  Created by Aleksandr Yegorov on 1/31/17.
//  Copyright © 2017 Aleksandr Yegorov. All rights reserved.
//

#import "FFOrganization+CoreDataProperties.h"

@implementation FFOrganization (CoreDataProperties)

+ (NSFetchRequest<FFOrganization *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FFOrganization"];
}

@dynamic name;
@dynamic employees;

@end
