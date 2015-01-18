//
//  BIStartersFactory.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 1/13/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BIStarter;

@interface BIStartersFactory : NSObject

- (void)run;
- (void)addStarter:(id<BIStarter>)starter;
- (void)loadStarters;

@end