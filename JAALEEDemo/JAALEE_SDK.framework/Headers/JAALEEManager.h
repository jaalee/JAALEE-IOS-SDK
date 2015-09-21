//
//  JAALEEManager.h
//  JAALEESDK
//
//  Created by jaalee on 15-8-22.
//  Copyright (c) 2015年 JAALEE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "JAALEERegion.h"
#import "JAALEE.h"
#import "EddystoneUID.h"

#define JAALEE_DEFAULT_PROXIMITY_UUID   [[NSUUID alloc] initWithUUIDString:@"EBEFD083-70A2-47C8-9837-E7B5634DF524"]

@class JAALEEManager;

/**
 
The JAALEEManagerDelegate protocol defines the delegate methods to respond for related events.
 */

@protocol JAALEEManagerDelegate <NSObject>

@optional

/**
 * Delegate method invoked during ranging.
 * Allows to retrieve NSArray of all discoverd JAALEE iBeacons
 * represented with JAALEE objects.
 *
 * @param manager JAALEE manager
 * @param beacons all beacons as JAALEE objects
 * @param region JAALEE ibeacon region
 *
 * @return void
 */
- (void)JAALEEManager:(JAALEEManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(JAALEERegion *)region;

/**
 * Delegate method invoked when ranging fails
 * for particular region. Related NSError object passed.
 *
 * @param manager JAALEE manager
 * @param region JAALEE ibeacon region
 * @param error object containing error info
 *
 * @return void
 */
-(void)JAALEEManager:(JAALEEManager *)manager rangingBeaconsDidFailForRegion:(JAALEERegion *)region
           withError:(NSError *)error;


/**
 * Delegate method invoked wehen monitoring fails
 * for particular region. Related NSError object passed.
 *
 * @param manager JAALEE manager
 * @param region JAALEE ibeacon region
 * @param error object containing error info
 *
 * @return void
 */
-(void)JAALEEManager:(JAALEEManager *)manager monitoringDidFailForRegion:(JAALEERegion *)region
           withError:(NSError *)error;

/**
 * Method triggered when iOS device enters JAALEE
 * ibeacon region during monitoring.
 *
 * @param manager JAALEE manager
 * @param region JAALEE ibeacon region
 *
 * @return void
 */
-(void)JAALEEManager:(JAALEEManager *)manager didEnterRegion:(JAALEERegion *)region;


/**
 * Method triggered when iOS device leaves JAALEE
 * ibeacon region during monitoring.
 *
 * @param manager JAALEE manager
 * @param region JAALEE ibeacon region
 *
 * @return void
 */
-(void)JAALEEManager:(JAALEEManager *)manager didExitRegion:(JAALEERegion *)region;

/**
 * Method triggered when JAALEE ibeacon region state
 * was determined using requestStateForRegion:
 *
 * @param manager JAALEE manager
 * @param state JAALEE ibeacon region state
 * @param region JAALEE ibeacon region
 *
 * @return void
 */
-(void)JAALEEManager:(JAALEEManager *)manager didDetermineState:(CLRegionState)state
           forRegion:(JAALEERegion *)region;


/**
 * Method triggered when location service not aviliable
 *
 * @param manager JAALEE manager
 * @param error Error message
 *
 * @return void
 */
-(void)JAALEEManager:(JAALEEManager *)manager locationServiceSettingError:(NSError*)error;


/**
 * Method triggered when location updates
 *
 * @param manager JAALEE manager
 * @param Locations locations is an array of CLLocation objects in chronological order.
 *
 * @return void
 */
-(void)JAALEEManager:(JAALEEManager *)manager didUpdateLocations:(NSArray*)Locations;


/**
 * Delegate method invoked during ranging Eddystone-URL beacons.
 * Allows to retrieve NSArray of all discoverd EddystoneURL beacons
 * represented with JAALEE objects.
 *
 * @param manager JAALEE manager
 * @param beacons all beacons as EddystoneURL objects
 *
 * @return void
 */
- (void)JAALEEManager:(JAALEEManager *)manager didFoundEddystoneURLBeacons:(NSArray *)beacons;

/**
 * Delegate method invoked during ranging Eddystone-UID beacons.
 *
 * @param manager JAALEE manager
 * @param beacon
 *
 * @return void
 */
- (void)JAALEEManager:(JAALEEManager *)manager didFindEddystoneUIDBeacon:(EddystoneUID *)beacon;

/**
 * Delegate method invoked during ranging Eddystone-UID beacons.
 *
 * @param manager JAALEE manager
 * @param beacon
 *
 * @return void
 */
- (void)JAALEEManager:(JAALEEManager *)manager didLoseEddystoneUIDBeacon:(EddystoneUID *)beacon;

/**
 * Delegate method invoked during ranging Eddystone-UID beacons.
 *
 * @param manager JAALEE manager
 * @param beacon
 *
 * @return void
 */
- (void)JAALEEManager:(JAALEEManager *)manager didUpdateEddystoneUIDBeacon:(EddystoneUID *)beacon;
@end



/**
 
 The JAALEEManager class defines the interface for range ibeacon and eddystone.
 
 */

@interface JAALEEManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id <JAALEEManagerDelegate> delegate;

/// @name CoreLocation based iBeacon monitoring and ranging methods

/**
 * Range all JAALEE ibeacons that are visible in range.
 * Delegate method beaconManager:didRangeBeacons:inRegion:
 * is used to retrieve found beacons. Returned NSArray contains
 * JAALEEBeacon objects.
 *
 * @param region JAALEE ibeacon region
 *
 * @return void
 */
-(void)startRangingBeaconsInRegion:(JAALEERegion*)region;

/**
 * Start monitoring for particular iBeacon region.
 * Functionality works in the background mode as well.
 * Every time you enter or leave ibeacon region appropriet
 * delegate method inovked: beaconManager:didEnterRegtion:
 * and beaconManager:didExitRegion:
 *
 * @param region JAALEE ibeacon region
 *
 * @return void
 */
-(void)startMonitoringForRegion:(JAALEERegion*)region;

/**
 * Stops ranging JAALEE ibeacons.
 *
 * @param region JAALEE ibeacon region
 *
 * @return void
 */
-(void)stopRangingBeaconsInRegion:(JAALEERegion*)region;

/**
 * Unsubscribe application from iOS monitoring of
 * JAALEE ibeacon region.
 *
 * @param region JAALEE ibeacon region
 *
 * @return void
 */
-(void)stopMonitoringForRegion:(JAALEERegion *)region;

/**
 * Allows to validate current state for particular ibeacon region
 *
 * @param region JAALEE ibeacon region
 *
 * @return void
 */
-(void)requestStateForRegion:(JAALEERegion *)region;


/**
 * Start Monitoring for geography position.
 * delegate method inovked:
 * JAALEEManager:didUpdateLocations:
 *
 * @return void
 */
-(void)startMonitoringGeographyPosition;


/**
 * Stops Monitoring Geography Position.
 *
 * @return void
 */
-(void)stopMonitoringGeographyPosition;


/**
 * Start scanning for eddystone beacons.
 * Every time you enter or leave eddystone beacon region appropriet
 * delegate method inovked: 
 * JAALEEManager:didFoundEddystoneURLBeacons:
 * JAALEEManager:didFindEddystoneUIDBeacon:
 * JAALEEManager:didLoseEddystoneUIDBeacon:
 * JAALEEManager:didUpdateEddystoneUIDBeacon:
 *
 *
 * @return void
 */
- (void)startScanningEddystoneBeacons;


/**
 * Stops Scan JAALEE eddystone beacons.
 *
 * @return void
 */
- (void)stopScanningEddystoneBeacons;
@end


