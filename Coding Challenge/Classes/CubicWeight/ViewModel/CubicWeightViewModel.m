//
//  CubicWeightViewModel.m
//  Coding Challenge
//
//  Created by Zhang Joey on 28/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import "CubicWeightViewModel.h"
#import "KGHTTPRequestManager.h"
#import "CubicWeightRequestResponse.h"
#import <YYKit.h>

@interface CubicWeightViewModel ()

@property (nonatomic, strong) NSMutableArray *dimsArray; // an array stores dims of each air conditioner, e.g. [[l,w,h], [l,w,h]...]
@property (nonatomic, assign) int totalCount; // total count of products
@property (nonatomic, assign) float averageCubicWeight; // average cubic weight for all air conditioners
@property (nonatomic, strong) KGHTTPRequestManager *httpManager; // Global singleton http requests manager
@property (nonatomic, strong) dispatch_group_t fetchDataGroup; // dispatch group for fetching data async
@property (nonatomic, strong) dispatch_queue_t fetchDataQueue; // dispatch queue for fetching data async

@end


@implementation CubicWeightViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _httpManager = [KGHTTPRequestManager manager];
        _dimsArray = [NSMutableArray new];
        _totalCount = 0;
        _averageCubicWeight = 0;
        _fetchDataGroup = dispatch_group_create();
        _fetchDataQueue = dispatch_get_global_queue(0, 0);
    }
    return self;
}

- (void)clearData {
    [self.dimsArray removeAllObjects];
    self.totalCount = 0;
    self.averageCubicWeight = 0;
}

- (void)refreshDataWithBlock:(void (^)(int, int, float))completionHandler {
    [self clearData];
    
    dispatch_group_enter(self.fetchDataGroup);
    dispatch_async(self.fetchDataQueue, ^{
        [self fetchData:KG_CUBIC_WEIGHT_BASE_API];
        dispatch_group_leave(self.fetchDataGroup);
    });
    
    __weak __typeof(self)weakSelf = self;
    dispatch_group_notify(self.fetchDataGroup, self.fetchDataQueue, ^{
        if (self.dimsArray.count == 0) {
            completionHandler(self.totalCount,0,0);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            int airConCount = (int)strongSelf.dimsArray.count;
            float totalCubicWeight = 0;
            for (NSArray *dims in self.dimsArray) {
                float cubicWeight = [dims[0] floatValue] * [dims[1] floatValue] * [dims[2] floatValue] * 250 / 1000000;
                totalCubicWeight += cubicWeight;
            }
            self.averageCubicWeight = totalCubicWeight/airConCount;
            completionHandler(self.totalCount,airConCount,self.averageCubicWeight);
        });
    });
}

- (void)fetchData:(NSString *)page {
    if (page == nil || [page isEqual:@"null"]) {
        return;
    }
    dispatch_group_enter(self.fetchDataGroup);
    __weak __typeof(self)weakSelf = self;
    [self.httpManager.HTTPSessionManager GET:[self.httpManager createAPIURL:page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        CubicWeightRequestResponse *requestResponse = [CubicWeightRequestResponse modelWithJSON:responseObject];
        NSArray *resultAry = requestResponse.objects;
        [resultAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            strongSelf.totalCount += 1;
            CubicWeightObjects *object = [CubicWeightObjects modelWithDictionary:obj];
            if ([object.category isEqual:@"Air Conditioners"]) {
                NSNumber *length = [NSNumber numberWithFloat:object.size.length];
                NSNumber *width = [NSNumber numberWithFloat:object.size.width];
                NSNumber *height = [NSNumber numberWithFloat:object.size.height];
                [strongSelf.dimsArray addObject:@[length, width, height]];
            }
        }];
        if (![requestResponse.next isEqualToString:@"null"]) {
            [strongSelf fetchData:requestResponse.next];
        }
        dispatch_group_leave(self.fetchDataGroup);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Request error: %@ Page: %@", error, page);
        dispatch_group_leave(self.fetchDataGroup);
    }];
}


@end
