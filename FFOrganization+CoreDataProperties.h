//
//  FFOrganization+CoreDataProperties.h
//  TutorialApplication
//
//  Created by Александр Егоров on 2/7/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import "FFOrganization+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FFOrganization (CoreDataProperties)

+ (NSFetchRequest<FFOrganization *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<FFEmployee *> *employees;

@end

@interface FFOrganization (CoreDataGeneratedAccessors)

- (void)addEmployeesObject:(FFEmployee *)value;
- (void)removeEmployeesObject:(FFEmployee *)value;
- (void)addEmployees:(NSSet<FFEmployee *> *)values;
- (void)removeEmployees:(NSSet<FFEmployee *> *)values;

@end

NS_ASSUME_NONNULL_END
