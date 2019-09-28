//
//  CubicWeightObjectSize.h
//  Coding Challenge
//
//  Created by Zhang Joey on 27/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "size": {
     "width": 15.0,
     "length": 13.0,
     "height": 1.0
 }
 */

NS_ASSUME_NONNULL_BEGIN

@interface CubicWeightObjectSize : NSObject

@property (nonatomic, assign) float width;
@property (nonatomic, assign) float length;
@property (nonatomic, assign) float height;

@end

NS_ASSUME_NONNULL_END
