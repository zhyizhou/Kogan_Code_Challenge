//
//  CubicWeightObjects.h
//  Coding Challenge
//
//  Created by Zhang Joey on 27/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CubicWeightObjectSize.h"

/*
 {
     "category": "Gadgets",
     "title": "10 Pack Family Car Sticker Decals",
     "weight": 120.0,
     "size": {
         "width": 15.0,
         "length": 13.0,
         "height": 1.0
     }
 },
 */

NS_ASSUME_NONNULL_BEGIN

@interface CubicWeightObjects : NSObject

@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) float weight;
@property (nonatomic, strong) CubicWeightObjectSize *size;

@end

NS_ASSUME_NONNULL_END
