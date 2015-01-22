//
//  BIDatasourceFetchedResultsCallbacksTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/20/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BIDatasourceFetchedResultsCallbacks.h"

@interface BIDatasourceFetchedResultsCallbacksTestCase : XCTestCase

@property (nonatomic, strong) BIDatasourceFetchedResultsCallbacks *datasource;

@end

@implementation BIDatasourceFetchedResultsCallbacksTestCase

#pragma mark - Setup methods

- (void)setUp {
    [super setUp];
    self.datasource = [BIDatasourceFetchedResultsCallbacks new];
}

- (void)tearDown {
    self.datasource = nil;
    [super tearDown];
}

#pragma mark - Test un/register did change object callback

- (void)testDidChangeObjectCallback {
    XCTAssertThrows([self.datasource registerDidChangeObjectCallback:nil], @"Should not allow nil registration.");

    // Test register
    NSFetchedResultsController *controller = mock([NSFetchedResultsController class]);
    id object = @2;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSFetchedResultsChangeType type = NSFetchedResultsChangeMove;
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    __block NSInteger callbackCalledCounter = 0;
    BIFetchedResultsDidChangeObjectCallback didChangeObjectCallback = ^(NSFetchedResultsController *testController, id testObject, NSIndexPath *testIndexPath, NSFetchedResultsChangeType testType,
                                                                        NSIndexPath *testNewIndexPath) {
        XCTAssertEqual(controller, testController);
        XCTAssertEqual(object, testObject);
        XCTAssertEqual(indexPath, testIndexPath);
        XCTAssertEqual(type, testType);
        XCTAssertEqual(newIndexPath, testNewIndexPath);
        callbackCalledCounter++;
    };

    [self.datasource registerDidChangeObjectCallback:didChangeObjectCallback];
    [self.datasource registerDidChangeObjectCallback:didChangeObjectCallback]; // Should not be important
    [self.datasource registerDidChangeObjectCallback:didChangeObjectCallback]; // Should not be important
    [self.datasource controller:controller didChangeObject:object atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    XCTAssertEqual(callbackCalledCounter, 1U, @"Should not be allowed to register multiple times with the same callback");
    

    // Test unregister
    XCTAssertThrows([self.datasource unregisterDidChangeObjectCallback:nil], @"Should not allow nil unregistration");

    callbackCalledCounter = 0;
    [self.datasource unregisterDidChangeObjectCallback:didChangeObjectCallback];
    [self.datasource controller:controller didChangeObject:object atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    XCTAssertEqual(callbackCalledCounter, 0U, @"Callback should not have been called. We have unregistered!");
}

#pragma mark - Test un/register did change section callback

- (void)testDidChangeSectionCallback {
    XCTAssertThrows([self.datasource registerDidChangeSectionCallback:nil], @"Should not allow nil registration.");
    
    // Test register
    NSFetchedResultsController *controller = mock([NSFetchedResultsController class]);
    id sectionInfo = mockProtocol(@protocol(NSFetchedResultsSectionInfo));
    NSUInteger sectionIndex = 1;
    NSFetchedResultsChangeType type = NSFetchedResultsChangeInsert;
    __block NSInteger callbackCalledCounter = 0;
    BIFetchedResultsDidChangeSectionCallback didChangeSectionCallback = ^(NSFetchedResultsController *testController, id<NSFetchedResultsSectionInfo> testSectionInfo, NSUInteger testSectionIndex, NSFetchedResultsChangeType testType) {
        XCTAssertEqual(controller, testController);
        XCTAssertEqual(sectionInfo, testSectionInfo);
        XCTAssertEqual(sectionIndex, testSectionIndex);
        XCTAssertEqual(type, testType);
        callbackCalledCounter++;
    };
    
    [self.datasource registerDidChangeSectionCallback:didChangeSectionCallback];
    [self.datasource registerDidChangeSectionCallback:didChangeSectionCallback]; // Should not be important
    [self.datasource registerDidChangeSectionCallback:didChangeSectionCallback]; // Should not be important
    [self.datasource controller:controller didChangeSection:sectionInfo atIndex:sectionIndex forChangeType:type];
    XCTAssertEqual(callbackCalledCounter, 1U, @"Should not be allowed to register multiple times with the same callback");
    

    // Test unregister
    XCTAssertThrows([self.datasource unregisterDidChangeSectionCallback:nil], @"Should not allow nil unregistration");

    callbackCalledCounter = 0;
    [self.datasource unregisterDidChangeSectionCallback:didChangeSectionCallback];
    [self.datasource controller:controller didChangeSection:sectionInfo atIndex:sectionIndex forChangeType:type];
    XCTAssertEqual(callbackCalledCounter, 0U, @"Callback should not have been called. We have unregistered!");
}


#pragma mark - Test un/register will change content

- (void)testWillChangeContentCallback {
    XCTAssertThrows([self.datasource registerWillChangeContentCallback:nil], @"Should not allow nil registration.");
    
    // Test register
    __block NSInteger callbackCalledCounter = 0;
    NSFetchedResultsController *controller = mock([NSFetchedResultsController class]);
    BIFetchedResultsWillChangeContentCallback willChangeContentCallback = ^(NSFetchedResultsController *testController) {
        XCTAssertEqual(controller, testController);
        callbackCalledCounter++;
    };
    
    [self.datasource registerWillChangeContentCallback:willChangeContentCallback];
    [self.datasource registerWillChangeContentCallback:willChangeContentCallback]; // Should not be important
    [self.datasource registerWillChangeContentCallback:willChangeContentCallback]; // Should not be important
    [self.datasource controllerWillChangeContent:controller];
    XCTAssertEqual(callbackCalledCounter, 1U, @"Should not be allowed to register multiple times with the same callback");
    

    // Test unregister
    XCTAssertThrows([self.datasource unregisterWillChangeContentCallback:nil], @"Should not allow nil unregistration");
    
    callbackCalledCounter = 0;
    [self.datasource unregisterWillChangeContentCallback:willChangeContentCallback];
    [self.datasource controllerWillChangeContent:controller];
    XCTAssertEqual(callbackCalledCounter, 0U, @"Callback should not have been called. We have unregistered!");
}

#pragma mark - Test un/register did change content

- (void)testDidChangeContentCallback {
    XCTAssertThrows([self.datasource registerDidChangeContentCallback:nil], @"Should not allow nil registration.");
    
    // Test register
    __block NSInteger callbackCalledCounter = 0;
    NSFetchedResultsController *controller = mock([NSFetchedResultsController class]);
    BIFetchedResultsDidChangeContentCallback didChangeContentCallback = ^(NSFetchedResultsController *testController) {
        XCTAssertEqual(controller, testController);
        callbackCalledCounter++;
    };
    
    [self.datasource registerDidChangeContentCallback:didChangeContentCallback];
    [self.datasource registerDidChangeContentCallback:didChangeContentCallback]; // Should not be important
    [self.datasource registerDidChangeContentCallback:didChangeContentCallback]; // Should not be important
    [self.datasource controllerDidChangeContent:controller];
    XCTAssertEqual(callbackCalledCounter, 1U, @"Should not be allowed to register multiple times with the same callback");
    
    
    // Test unregister
    XCTAssertThrows([self.datasource unregisterDidChangeContentCallback:nil], @"Should not allow nil unregistration");
    
    callbackCalledCounter = 0;
    [self.datasource unregisterDidChangeContentCallback:didChangeContentCallback];
    [self.datasource controllerDidChangeContent:controller];
    XCTAssertEqual(callbackCalledCounter, 0U, @"Callback should not have been called. We have unregistered!");
}

@end
