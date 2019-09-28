//
//  Coding_ChallengeTests.m
//  Coding ChallengeTests
//
//  Created by Zhang Joey on 26/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CubicWeightViewModel.h"

@interface Coding_ChallengeTests : XCTestCase

@end

@implementation Coding_ChallengeTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    CubicWeightViewModel *viewModel = [[CubicWeightViewModel alloc] init];
    [viewModel refreshDataWithBlock:^(int totalCount, int airCount, float aveCubicWeight) {
        XCTAssert(totalCount < 0);
        XCTAssert(airCount < 0);
        XCTAssert(aveCubicWeight < 0);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
