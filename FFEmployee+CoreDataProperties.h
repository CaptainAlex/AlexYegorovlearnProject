//
//  FFEmployee+CoreDataProperties.h
//  TutorialApplication
//
//  Created by Александр Егоров on 2/7/17.
//  Copyright © 2017 Александр Егоров. All rights reserved.
//

#import "FFEmployee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FFEmployee (CoreDataProperties)

+ (NSFetchRequest<FFEmployee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nonatomic) int16_t salary;
@property (nullable, nonatomic, retain) FFOrganization *organization;

@end

NS_ASSUME_NONNULL_END
