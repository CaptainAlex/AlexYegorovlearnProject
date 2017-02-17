//
//  DatabaseController.m
//  Perfect
//
//  Created by Igor on 19.03.13.
//

#import "DatabaseController.h"
//#import "Photo.h"
//#import "Document.h"
//#import "Survey+Custom.h"

#define asyncQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)

@implementation DatabaseController

#pragma mark Singleton initialization

+ (DatabaseController *)sharedInstance
{
    static DatabaseController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [DatabaseController new];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initCoreData];
    }
    
    return self;
}

+ (NSString *)documentsPath
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
}

- (void)initCoreData
{
    NSError *error;
    
    NSString *path = [self.class documentsPath];
    path = [path stringByAppendingPathComponent:@"TutorialApplication.sqlite"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @true, NSInferMappingModelAutomaticallyOption: @true};
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:options error:&error])
    {
        NSLog(@"Core Data initialization error: %@", error);
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        [self initCoreData];
        return;
    }
    
    _context = [NSManagedObjectContext new];
    [_context setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    dispatch_async(asyncQueue, ^{
        self->_asyncContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSConfinementConcurrencyType];
        self->_asyncContext.persistentStoreCoordinator = persistentStoreCoordinator;
    });
    
    NSError *err = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:[url path]])
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:[url path] withIntermediateDirectories:true attributes:nil error:nil])
        {
            NSLog(@"Error excluding %@ from backup %@", [url lastPathComponent], err);
        }
        else
        {
            BOOL success = [url setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:&err];
            if (!success)
            {
                NSLog(@"Error excluding %@ from backup %@", [url lastPathComponent], err);
            }
        }
    }
}

+ (void)removeAllObjectsOfEntity:(NSString *)entity
{
    [self removeAllObjectsOfEntity:entity fromContext:[DatabaseController sharedInstance].context];
}

+ (void)removeAllObjectsOfEntity:(NSString *)entity fromContext:(NSManagedObjectContext *)context
{
    NSArray *allObjects = [DatabaseController requestResultsForPredicate:nil sortDescriptors:nil entity:entity fromContext:context];
    for (NSManagedObject *obj in allObjects)
    {
        [context deleteObject:obj];
    }
    [DatabaseController saveContext:context];
}

+ (void)purgeDatabaseWithContext:(NSManagedObjectContext *)context
{
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSArray *allEntities = [model entities];
    
    for (NSEntityDescription *entity in allEntities)
    {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity.name];
        NSArray *objects = [context executeFetchRequest:request error:nil];
        for (NSManagedObject *obj in objects)
        {
            [context deleteObject:obj];
        }
        [DatabaseController saveContext:context];
    }
}

+ (void)purgeDatabaseAsync:(bool)async withCompletionBlock:(DatabasePurgeCompletionBlock)completion
{
    if (async)
    {
        dispatch_async(asyncQueue, ^{
            [self purgeDatabaseWithContext:[DatabaseController sharedInstance].asyncContext];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[DatabaseController sharedInstance].context reset];
            });
            if (completion)
            {
                completion();
            }
        });
    }
    else
    {
        [self purgeDatabaseWithContext:[DatabaseController sharedInstance].context];
        if (completion)
        {
            completion();
        }
    }
}

+ (void)purgeDatabase
{
    [self purgeDatabaseAsync:false withCompletionBlock:nil];
}

+ (void)saveContext
{
    NSManagedObjectContext *context = [DatabaseController sharedInstance].context;
    [self saveContext:context];
}

+ (void)saveAsyncContext
{
    dispatch_async(asyncQueue, ^{
        [self saveContext:[DatabaseController sharedInstance].asyncContext];
    });
}

+ (void)saveContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    if (![context save:&error])
    {
        NSLog(@"Error while saving context: %@", error);
    }
    if (error)
    {
        NSLog(@"Error while saving context: %@", error);
    }
}

+ (NSArray *)requestResultsForPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors entity:(NSString *)entity fromContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity];
    NSError *error = nil;
    if (predicate)
    {
        request.predicate = predicate;
    }
    if (sortDescriptors)
    {
        request.sortDescriptors = sortDescriptors;
    }
    NSArray *matches = [context executeFetchRequest:request error:&error];
    if (error)
    {
        NSLog(@"Error while fetching from DB:\n%@", error);
    }
    return matches;
}

+ (NSArray *)requestResultsForPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors entity:(NSString *)entity
{
    return [self requestResultsForPredicate:predicate sortDescriptors:sortDescriptors entity:entity fromContext:[DatabaseController sharedInstance].context];
}

@end
