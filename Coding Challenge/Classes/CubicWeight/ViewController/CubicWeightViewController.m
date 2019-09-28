//
//  CubicWeightViewController.m
//  Coding Challenge
//
//  Created by Zhang Joey on 27/9/19.
//  Copyright © 2019 Kogan.com. All rights reserved.
//

#import "CubicWeightViewController.h"
#import "CubicWeightViewModel.h"

@interface CubicWeightViewController ()

@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel; // a label shows the total count of products
@property (weak, nonatomic) IBOutlet UILabel *totalCountTextLabel; // a place holder label shows the title "Total count"
@property (weak, nonatomic) IBOutlet UILabel *airConCountLabel; // a label shows the count of air conditioners
@property (weak, nonatomic) IBOutlet UILabel *airConTextLabel; // a place holder label shows the title "Air conditioner"
@property (weak, nonatomic) IBOutlet UILabel *averageCubicWeightTextLabel; // a place holder label shows the title "Average Cubic Weight"
@property (weak, nonatomic) IBOutlet UILabel *cubicWeightResultLabel; // a label shows the average cubic weight for all air conditioners
@property (weak, nonatomic) IBOutlet UIButton *calculateButton; // click to calculate average cubic weight

@property (nonatomic, strong) NSMutableArray *dimsArray; // an array stores dims of each air conditioner, e.g. [[l,w,h], [l,w,h]...]
@property (nonatomic, assign) int totalCount; // total count of products
@property (nonatomic, assign) float averageCubicWeight; // average cubic weight for all air conditioners

@property (nonatomic, strong) CubicWeightViewModel *cubicWeightViewModel;

@end

@implementation CubicWeightViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _cubicWeightViewModel = [[CubicWeightViewModel alloc] init];
}

#pragma mark - Private functions

- (IBAction)calculateBtnClicked:(id)sender {
    __weak __typeof(self)weakSelf = self;
    [self.cubicWeightViewModel refreshDataWithBlock:^(int totalCount, int airCount, float aveCubicWeight) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf.totalCountLabel setText:[NSString stringWithFormat:@"%d", totalCount]];
            [strongSelf.airConCountLabel setText:[NSString stringWithFormat:@"%d", airCount]];
            [strongSelf.cubicWeightResultLabel setText:[NSString stringWithFormat:@"%lu kg", (unsigned long)aveCubicWeight]];
        });
    }];
}

@end
