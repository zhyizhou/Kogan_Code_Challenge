//
//  KGHTTPRequestManager.m
//  Coding Challenge
//
//  Created by Zhang Joey on 27/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import "KGHTTPRequestManager.h"

@implementation KGHTTPRequestManager
+ (KGHTTPRequestManager *)sharedInstance {
    return [[self alloc] init];
}
+(KGHTTPRequestManager *) manager {
    return [self sharedInstance];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static KGHTTPRequestManager *theSharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        theSharedInstance = [super allocWithZone:zone];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.operationQueue.maxConcurrentOperationCount = 5;
        manager.requestSerializer.timeoutInterval= 30.f;
        manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        theSharedInstance.HTTPSessionManager = manager;
        
    });
    return theSharedInstance;
}

- (NSString *)createAPIURL:(NSString * _Nonnull)apiString {
    return [NSString stringWithFormat:@"%@%@", KG_CUBIC_WEIGHT_BASE_URL, apiString];
}



@end
