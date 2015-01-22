//
//  BIDatasourceFetchedResultsCallbacks.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/20/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFetchedResultsBase.h"

typedef void(^BIFetchedResultsDidChangeObjectCallback)(NSFetchedResultsController *controller, id anObject, NSIndexPath *indexPath, NSFetchedResultsChangeType type,
                                                       NSIndexPath *newIndexPath);

typedef void(^BIFetchedResultsDidChangeSectionCallback)(NSFetchedResultsController *controller, id<NSFetchedResultsSectionInfo> sectionInfo, NSUInteger sectionIndex, NSFetchedResultsChangeType type);
typedef void(^BIFetchedResultsWillChangeContentCallback)(NSFetchedResultsController *controller);
typedef void(^BIFetchedResultsDidChangeContentCallback)(NSFetchedResultsController *controller);

@interface BIDatasourceFetchedResultsCallbacks : BIDatasourceFetchedResultsBase

- (void)registerDidChangeObjectCallback:(BIFetchedResultsDidChangeObjectCallback)callback;
- (void)unregisterDidChangeObjectCallback:(BIFetchedResultsDidChangeObjectCallback)callback;

- (void)registerDidChangeSectionCallback:(BIFetchedResultsDidChangeSectionCallback)callback;
- (void)unregisterDidChangeSectionCallback:(BIFetchedResultsDidChangeSectionCallback)callback;

- (void)registerWillChangeContentCallback:(BIFetchedResultsWillChangeContentCallback)callback;
- (void)unregisterWillChangeContentCallback:(BIFetchedResultsWillChangeContentCallback)callback;

- (void)registerDidChangeContentCallback:(BIFetchedResultsDidChangeContentCallback)callback;
- (void)unregisterDidChangeContentCallback:(BIFetchedResultsDidChangeContentCallback)callback;

@end
