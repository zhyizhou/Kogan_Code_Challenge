//
//  CubicWeightRequestResponse.h
//  Coding Challenge
//
//  Created by Zhang Joey on 27/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CubicWeightObjects.h"

/*
{
    "objects": [
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
    ],
    "next": "/api/products/2"
}
 */

NS_ASSUME_NONNULL_BEGIN

@interface CubicWeightRequestResponse : NSObject

@property (nonatomic, strong) NSArray<CubicWeightObjects *> *objects;
@property (nonatomic, strong) NSString *next;

@end

NS_ASSUME_NONNULL_END
