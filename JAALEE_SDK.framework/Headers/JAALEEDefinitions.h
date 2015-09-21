//
//  JAALEEDefinitions.h
//  JAALEESDK
//
//  Created by jaalee on 15-8-22.
//  Copyright (c) 2015年 JAALEE. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : char
{
    JAALEEPowerLevel1 = 4,
    JAALEEPowerLevel2 = 0,
    JAALEEPowerLevel3 = -4,
    JAALEEPowerLevel4 = -8,
    JAALEEPowerLevel5 = -12,
    JAALEEPowerLevel6 = -16,
    JAALEEPowerLevel7 = -20,
    JAALEEPowerLevel8 = -30,
    JAALEEPowerLevel9 = -40
} JAALEETXPower;

typedef NS_ENUM(NSInteger, JAALEE_BUTTON_TOUCH) {
    JAALEE_BUTTON_TOUCH_SIGNAL = 0,
    JAALEE_BUTTON_TOUCH_DOUBLE,
    JAALEE_BUTTON_TOUCH_LONG,
    JAALEE_BUTTON_TOUCH_DOUBLE_UNKNOWN
};

typedef NS_ENUM(NSInteger, JAALEE_CHANNEL_SELECT) {
    JAALEE_CHANNEL_IBEACON,
    JAALEE_CHANNEL_CUSTOM_1,
    JAALEE_CHANNEL_CUSTOM_2,
    JAALEE_CHANNEL_NONE
};


typedef NS_ENUM(NSInteger, JAALEE_SENSOR_SENSITIVE) {
    JAALEE_SENSOR_SENSITIVE_HIGH,
    JAALEE_SENSOR_SENSITIVE_MEDIUM,
    JAALEE_SENSOR_SENSITIVE_LOW
};

typedef void(^JAALEEBoolCompletionBlock) (BOOL value, NSError* error);


////////////////////////////////////////////////////////////////////
// Interface definition

@interface JAALEEBeaconDefinitions : NSObject

@end
