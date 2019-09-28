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

/// A singleton HTTP manager that manges all HTTP requests.
@interface KGHTTPRequestManager : NSObject

/// property HTTPSessionManager is the actual HTTP Session Manager, which is  AFHTTPSessionManager from AFNetworking
@property (nonatomic, strong) AFHTTPSessionManager *HTTPSessionManager;

/*
 HTTP request manager is a singleton, only sharedInstance and manager are available
 */
+(instancetype) new __attribute__((unavailable("call sharedInstance or manager instead")));
-(instancetype) copy __attribute__((unavailable("call sharedInstance or manager instead")));
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance or manager instead")));

/*
 Both sharedInstance and manager will get the same singleton instance
 */
+(KGHTTPRequestManager *) sharedInstance;
+(KGHTTPRequestManager *) manager;


/// Get a full URL for cubic weight API endpoints
/// @param apiString the API part following with the base URL, e.g. "/api/products/1"
- (NSString *)createAPIURL:(NSString * _Nonnull)apiString;


@end

NS_ASSUME_NONNULL_END
