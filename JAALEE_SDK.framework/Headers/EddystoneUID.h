//
//  EddystoneUID.h
//  JAALEE_SDK
//
//  Created by jaalee on 15-8-22.
//  Copyright (c) 2015年 JAALEE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EddystoneUID : NSObject


- (id)initWithObject:(id)object;
/**
 * The most recent RSSI we got for this sighting. Sometimes the OS cannot compute one reliably, so
 * this value can be null.
 */
@property(nonatomic, strong, readonly) NSNumber *RSSI;

/**
 * The raw beaconID data.
 */
@property(nonatomic, copy, readonly) NSData *beaconID;

/**
 * The telemetry that may or may not have been seen for this beacon. If it's set, the contents of
 * it aren't terribly relevant to us, in general. See the Eddystone spec for more information
 * if you're really interested in the exact details.
 */
@property(nonatomic, copy, readonly) NSData *telemetry;

/**
 * Transmission power reported by beacon. This is in dB.
 */
@property(nonatomic, strong, readonly) NSNumber *MeasuredPower;


/**
 * The namespace ID of Eddystone-UID Beacon.
 */
@property(nonatomic, copy, readonly) NSString *namespaceID;

/**
 * The instances ID of Eddystone-UID Beacon.
 */
@property(nonatomic, copy, readonly) NSString *instanceID;

@end
