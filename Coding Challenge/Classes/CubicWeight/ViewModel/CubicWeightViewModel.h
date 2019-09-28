//
//  CubicWeightViewModel.h
//  Coding Challenge
//
//  Created by Zhang Joey on 28/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CubicWeightViewModel : NSObject

/// Asynchronously fetch all data, and calculate for average cubic weight
/// @param completionHandler return total count of all product, the number of air conditioners, and the average cuibic weight of all air conditioners
- (void)refreshDataWithBlock:(void(^)(int totalCount, int airCount, float aveCubicWeight))completionHandler;

@end

NS_ASSUME_NONNULL_END
