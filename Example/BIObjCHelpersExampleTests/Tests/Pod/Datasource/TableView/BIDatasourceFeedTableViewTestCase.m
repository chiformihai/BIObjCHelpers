//
//  BIDatasourceFeedTableViewTestCase.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 14/07/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "BITableViewBatch.h"

#import "BIMockDatasourceFeedTableView.h"

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <SVPullToRefresh/SVPullToRefresh.h>

@interface BIDatasourceFeedTableViewTestCase : XCTestCase

@property (nonatomic, strong, nullable) UITableView *tableView;
@property (nonatomic, strong, nullable) BIMockDatasourceFeedTableView *datasource;

@end

@implementation BIDatasourceFeedTableViewTestCase

- (void)setUp {
    [super setUp];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.datasource = [BIMockDatasourceFeedTableView datasourceWithTableView:self.tableView];
    [self.datasource load];
}

- (void)tearDown {
    self.tableView = nil;
    self.datasource = nil;
    [super tearDown];
}

#pragma mark - Test createNextBatch

- (void)testCreateNextBatchCallback {
    __block BOOL wasCalled = NO;
    __block BITableViewBatch *batch;
    self.datasource.createNextBatchCallback = ^() {
        wasCalled = YES;
        batch = [[BITableViewBatch alloc] initWithCompletionBlock:nil];
        return batch;
    };
    [self.tableView triggerInfiniteScrolling];
    XCTAssertTrue(wasCalled);
    XCTAssertEqual(batch, self.datasource.currentBatch);
}

#pragma mark - Test fetchBatch

- (void)testFetchBatch {
    __block BOOL wasCalled = NO;
    self.datasource.fetchBatchCallback = ^(BITableViewBatch * __nonnull batch) {
        wasCalled = YES;
    };
    [self.tableView triggerInfiniteScrolling];
    XCTAssertTrue(wasCalled);
    XCTAssertEqual(self.tableView.infiniteScrollingView.state, SVInfiniteScrollingStateLoading);
}

#pragma mark - Test fetchBatchCompletedWithFailure

- (void)testFetchBatchCompletedWithFailure {
    __block NSError *returnedError = nil;
    NSError *sentError = [[NSError alloc] init];
    self.datasource.fetchBatchCompletedWithFailureCallback = ^(NSError * __nonnull error) {
        returnedError = error;
    };
    [self.tableView triggerInfiniteScrolling];
    self.datasource.currentBatch.completionBlock(sentError, nil);
    XCTAssertEqual(sentError, returnedError);
}

#pragma mark - Test fetchBatchCompletedWithSuccess

- (void)testFetchBatchCompletedWithSuccess {
    __block NSArray *returnedItems = nil;
    NSArray *sentItems = @[];
    self.datasource.fetchBatchCompletedWithSuccessCallback = ^(NSArray * __nonnull items) {
        returnedItems = items;
    };
    [self.tableView triggerInfiniteScrolling];
    self.datasource.currentBatch.completionBlock(nil, sentItems);
    XCTAssertEqual(sentItems, returnedItems);
}

#pragma mark - Test fetchBatchCompletedCommon

- (void)testFetchBatchCompletedCommon {
    [self.tableView triggerInfiniteScrolling];
    [self.datasource fetchBatchCompletedCommon];
    XCTAssertEqual(self.tableView.infiniteScrollingView.state, SVInfiniteScrollingStateStopped);
    XCTAssertNil(self.datasource.currentBatch);
}

@end
