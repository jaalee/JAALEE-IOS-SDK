//
//  SecondViewController.m
//  JAALEEDemo
//
//  Created by jaalee on 15/9/16.
//  Copyright (c) 2015年 JAALEE. All rights reserved.
//

#import "SecondViewController.h"
#import <JAALEE_SDK/JAALEESDK.h>

@interface SecondViewController ()<JAALEEConfigureManagerDelegate>

@property (nonatomic, strong) JAALEEConfigureManager *_ConfigureManager;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __ConfigureManager = [[JAALEEConfigureManager alloc] init];
    __ConfigureManager.delegate = self;
    
    [__ConfigureManager setJAALEEDeveloperAPIKey:@"your developer key"];
}


-(void)viewDidAppear:(BOOL)animated
{
    [self startDiscoverJAALEEs:true];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self startDiscoverJAALEEs:false];
}


-(void) startDiscoverJAALEEs:(BOOL)state
{
    if (state) {
        if (![__ConfigureManager startDiscoveryJAALEE])
            NSLog(@"start discover jaalee failed");
    }
    else
        [__ConfigureManager stopJAALEEDiscovery];
}


#pragma JAALEEConfigureManagerDelegate method
- (void)JAALEEConfigureManager:(JAALEEConfigureManager *)manager networkError:(NSError *)error
{
    NSLog(@"error: %@", error);
}

- (void)JAALEEConfigureManager:(JAALEEConfigureManager *)manager didDiscoverJAALEE:(JAALEEDevice *)JAALEE RSSI:(NSNumber *)RSSI
{
    NSLog(@"JAALEE ID: %@    RSSI:%d", JAALEE.JAALEEID, [RSSI intValue]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
