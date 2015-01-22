//
//  BIDatasourceFetchedResultsCallbacks.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/20/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFetchedResultsCallbacks.h"

@interface BIDatasourceFetchedResultsCallbacks ()

@property  (nonatomic, strong) NSMutableOrderedSet *didChangeObjectCallbacks;
@property  (nonatomic, strong) NSMutableOrderedSet *didChangeSectionCallbacks;
@property  (nonatomic, strong) NSMutableOrderedSet *willChangeContentCallbacks;
@property  (nonatomic, strong) NSMutableOrderedSet *didChangeContentCallbacks;

@end


@implementation BIDatasourceFetchedResultsCallbacks

#pragma  mark - Public methods

- (void)registerDidChangeObjectCallback:(BIFetchedResultsDidChangeObjectCallback)callback {
    NSParameterAssert(callback);
    [self.didChangeObjectCallbacks addObject:callback];
}

- (void)unregisterDidChangeObjectCallback:(BIFetchedResultsDidChangeObjectCallback)callback {
    NSParameterAssert(callback);
    [self.didChangeObjectCallbacks removeObject:callback];
}

- (void)registerDidChangeSectionCallback:(BIFetchedResultsDidChangeSectionCallback)callback {
    NSParameterAssert(callback);
    [self.didChangeSectionCallbacks addObject:callback];
}

- (void)unregisterDidChangeSectionCallback:(BIFetchedResultsDidChangeSectionCallback)callback {
    NSParameterAssert(callback);
    [self.didChangeSectionCallbacks removeObject:callback];
}

- (void)registerWillChangeContentCallback:(BIFetchedResultsWillChangeContentCallback)callback {
    NSParameterAssert(callback);
    [self.willChangeContentCallbacks addObject:callback];
}

- (void)unregisterWillChangeContentCallback:(BIFetchedResultsWillChangeContentCallback)callback {
    NSParameterAssert(callback);
    [self.willChangeContentCallbacks removeObject:callback];
}

- (void)registerDidChangeContentCallback:(BIFetchedResultsDidChangeContentCallback)callback {
    NSParameterAssert(callback);
    [self.didChangeContentCallbacks addObject:callback];
}

- (void)unregisterDidChangeContentCallback:(BIFetchedResultsDidChangeContentCallback)callback {
    NSParameterAssert(callback);
    [self.didChangeContentCallbacks removeObject:callback];
}

#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    [self.didChangeSectionCallbacks enumerateObjectsUsingBlock:^(BIFetchedResultsDidChangeSectionCallback callback, NSUInteger idx, BOOL *stop) {
        callback(controller, sectionInfo, sectionIndex, type);
    }];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    [self.didChangeObjectCallbacks enumerateObjectsUsingBlock:^(BIFetchedResultsDidChangeObjectCallback callback, NSUInteger idx, BOOL *stop) {
        callback(controller, anObject, indexPath, type, newIndexPath);
    }];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.willChangeContentCallbacks enumerateObjectsUsingBlock:^(BIFetchedResultsWillChangeContentCallback callback, NSUInteger idx, BOOL *stop) {
        callback(controller);
    }];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.didChangeContentCallbacks enumerateObjectsUsingBlock:^(BIFetchedResultsDidChangeContentCallback callback, NSUInteger idx, BOOL *stop) {
        callback(controller);
    }];
}

#pragma mark - Property

- (NSMutableOrderedSet *)didChangeObjectCallbacks {
    if (!_didChangeObjectCallbacks) {
        _didChangeObjectCallbacks = [NSMutableOrderedSet new];
    }
    return _didChangeObjectCallbacks;
}

- (NSMutableOrderedSet *)didChangeSectionCallbacks {
    if (!_didChangeSectionCallbacks) {
        _didChangeSectionCallbacks = [NSMutableOrderedSet new];
    }
    return _didChangeSectionCallbacks;
}

- (NSMutableOrderedSet *)willChangeContentCallbacks {
    if (!_willChangeContentCallbacks) {
        _willChangeContentCallbacks = [NSMutableOrderedSet new];
    }
    return _willChangeContentCallbacks;
}

- (NSMutableOrderedSet *)didChangeContentCallbacks {
    if (!_didChangeContentCallbacks) {
        _didChangeContentCallbacks = [NSMutableOrderedSet new];
    }
    return _didChangeContentCallbacks;
}

@end
