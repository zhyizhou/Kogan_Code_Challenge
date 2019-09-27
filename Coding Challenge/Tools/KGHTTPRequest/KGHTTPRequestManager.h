//
//  KGHTTPRequestManager.h
//  Coding Challenge
//
//  Created by Zhang Joey on 27/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface KGHTTPRequestManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *HTTPSessionManager;


+(KGHTTPRequestManager *) sharedInstance;
+(KGHTTPRequestManager *) manager;
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));

- (NSString *)createAPIURL:(NSString * _Nonnull)apiString;


@end

NS_ASSUME_NONNULL_END
