//
//  JAALEERegion.h
//  JAALEESDK
//
//  Created by jaalee on 15-8-22.
//  Copyright (c) 2015年 JAALEE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/*
 *  JAALEERegion
 *
 *  Discussion:
 *    A region containing similar ibeacons.
 *
 *    Such a region can be defined by proximityUUID, major and minor values.
 *    proximityUUID must be specified. If proximityUUID is only specified, the major and
 *    minor values will be wildcarded and the region will match any beacons with the same
 *    proximityUUID. Similarly if only proximityUUID and major value are specified, the minor value will be
 *    wildcarded and the region will match against any beacons with the same proximityUUID and major
 *    value.
 *
 */

@interface JAALEERegion : CLBeaconRegion

@end

