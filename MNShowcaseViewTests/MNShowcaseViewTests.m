//
//  MNShowcaseViewTests.m
//  MNShowcaseViewTests
//
//  Created by Nabeel Arif on 10/12/15.
//  Copyright © 2015 Muhammad Nabeel Arif. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MNShowcaseView.h"

@interface MNShowcaseView (hack)
@property (nonatomic,strong) NSArray<MNShowcaseItem*> *showcaseItems;
@end
@interface MNShowcaseViewTests : XCTestCase

@end

@implementation MNShowcaseViewTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitializeWithTitleAndDesc {
    NSString *title = @"Title";
    NSString *description = @"Description";
    MNShowcaseView *showcase = [[MNShowcaseView alloc] initWithViewToFocus:[[UIView alloc] init] title:title description:description];
    XCTAssertNotNil(showcase, @"ShowcaseView is initialized");
    XCTAssertTrue(showcase.showcaseItems.count==1, @"There is one item in showcaseView");
}

@end
