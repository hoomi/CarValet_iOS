//
//  Utils.h
//  CarValet
//
//  Created by Hooman Ostovari on 21/02/2014.
//  Copyright (c) 2014 Hooman Ostovari. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline BOOL IsEmpty(id thing) {
    return thing == nil
    || [thing isKindOfClass:[NSNull class]]
	|| ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
	|| ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

static inline BOOL IsDictionary(id dict) {
    return (!IsEmpty(dict) && [dict isKindOfClass:[NSDictionary class]]);
}

static inline BOOL IsArray(id array) {
    return (!IsEmpty(array) && [array isKindOfClass:[NSArray class]]);
}

static inline BOOL IsString(id string) {
    return (!IsEmpty(string) && [string isKindOfClass:[NSString class]]);
}

static inline BOOL IsNSNumber(id number) {
    return (!IsEmpty(number) && [number isKindOfClass:[NSNumber class]]);
}

static inline BOOL IsEmptyString (NSString* string) {
    return (string != nil && [string length]>0);
}

@interface Utils : NSObject

+ (NSString*)localizeDouble:(double) floatValue;
+ (NSString *)localizeDouble:(double)floatValue precision:(NSInteger) precision;
+ (NSString *)localizeLong:(long)longValue;
+ (NSString *)localizeDateWithYear:(long)year month:(NSInteger)month day:(NSInteger)day format:(NSString*) format;
+ (NSString *)localizeDateWithYear:(long)year month:(NSInteger)month day:(NSInteger)day;
+ (NSString *)localizeDateWithYear:(long)year month:(NSInteger)month;
+ (NSString *)localizeDateWithYear:(long)year;

@end
