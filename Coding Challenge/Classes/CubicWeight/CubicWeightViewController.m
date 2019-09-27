//
//  CubicWeightViewController.m
//  Coding Challenge
//
//  Created by Zhang Joey on 27/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import "CubicWeightViewController.h"
#import "KGHTTPRequestManager.h"
#import "CubicWeightRequestResponse.h"
#import <YYKit.h>

@interface CubicWeightViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCountTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *airConCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *airConTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageCubicWeightTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *cubicWeightResultLabel;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@property (nonatomic, strong) NSMutableArray *dimsArray;
@property (nonatomic, assign) int totalCount;
@property (nonatomic, assign) float averageCubicWeight;

@end

@implementation CubicWeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _dimsArray = [NSMutableArray new];
    _totalCount = 0;
    _averageCubicWeight = 0;
    
    [self setUI];
    [self fetchData:KG_CUBIC_WEIGHT_BASE_API];
    
}

- (void)setUI {
    [self.totalCountLabel setText:[NSString stringWithFormat:@"%d", self.totalCount]];
    [self.airConCountLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)self.dimsArray.count]];
    [self.cubicWeightResultLabel setText:[NSString stringWithFormat:@"%lu kg", (unsigned long)self.averageCubicWeight]];
}

- (IBAction)calculateBtnClicked:(id)sender {
    float totalCubicWeight = 0;
    for (NSArray *dims in self.dimsArray) {
        if (dims.count != 3) {
            continue;
        }
        float cubicWeight = [dims[0] floatValue] * [dims[1] floatValue] * [dims[2] floatValue] * 250 / 1000000;
        totalCubicWeight += cubicWeight;
    }
    self.averageCubicWeight = totalCubicWeight/self.dimsArray.count;
    
    [self setUI];
    
}
- (void)fetchData:(NSString *)page {
    if (page == nil || [page isEqual:@"null"]) {
        return;
    }
    KGHTTPRequestManager *manager = [KGHTTPRequestManager manager];
    __weak __typeof(self)weakSelf = self;
    [manager.HTTPSessionManager GET:[manager createAPIURL:page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Request error: %@", page);
    }];
}

@end
