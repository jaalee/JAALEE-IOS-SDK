//
//  FirstViewController.m
//  JAALEEDemo
//
//  Created by jaalee on 15/9/16.
//  Copyright (c) 2015年 JAALEE. All rights reserved.
//

#import "FirstViewController.h"
#import <JAALEE_SDK/JAALEESDK.h>

@interface FirstViewController ()<JAALEEManagerDelegate>

@property (nonatomic, strong) JAALEEManager *_JAALEEManager;
@property (nonatomic, strong) JAALEERegion *iBeaconRegion;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __JAALEEManager = [[JAALEEManager alloc] init];
    __JAALEEManager.delegate = self;
    
    _iBeaconRegion = [[JAALEERegion alloc] initWithProximityUUID:JAALEE_DEFAULT_PROXIMITY_UUID identifier:@"com.jaalee"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self startDetectAllBeacons:true];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self startDetectAllBeacons:false];
}

-(void) startDetectAllBeacons:(BOOL)state
{
    if (state) {
        [__JAALEEManager startRangingBeaconsInRegion:_iBeaconRegion];
        [__JAALEEManager startScanningEddystoneBeacons];
        [__JAALEEManager startMonitoringGeographyPosition];
    }
    else
    {
        [__JAALEEManager stopRangingBeaconsInRegion:_iBeaconRegion];
        [__JAALEEManager stopScanningEddystoneBeacons];
        [__JAALEEManager stopMonitoringGeographyPosition];
    }
}



#pragma JAALEEManagerDelegate Method
-(void)JAALEEManager:(JAALEEManager *)manager locationServiceSettingError:(NSError *)error
{
    NSLog(@"ERROR MESSAGE: %@", error);
}

- (void)JAALEEManager:(JAALEEManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(JAALEERegion *)region
{
    NSLog(@"Range iBeacons: %@", beacons);
}

- (void)JAALEEManager:(JAALEEManager *)manager didUpdateEddystoneUIDBeacon:(EddystoneUID *)beacon
{
    NSLog(@"Range Eddystone-UID beacon: %@", beacon);
}

- (void)JAALEEManager:(JAALEEManager *)manager didFoundEddystoneURLBeacons:(NSArray *)beacons
{
    NSLog(@"Range Eddystone-URL beacons: %@", beacons);
}

-(void)JAALEEManager:(JAALEEManager *)manager didUpdateLocations:(NSArray *)Locations
{
    NSLog(@"Geography position updated: %@", Locations);
}

@end
