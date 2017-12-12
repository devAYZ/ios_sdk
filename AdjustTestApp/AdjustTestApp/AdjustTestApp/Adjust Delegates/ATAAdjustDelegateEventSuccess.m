//
//  ATAAdjustDelegateEventSuccess.m
//  AdjustTestApp
//
//  Created by Uglješa Erceg (uerceg) on 8th December 2017.
//  Copyright © 2017 Adjust GmbH. All rights reserved.
//

#import "ATAAdjustDelegateEventSuccess.h"

@interface ATAAdjustDelegateEventSuccess ()

@property (nonatomic, strong) ATLTestLibrary *testLibrary;

@end

@implementation ATAAdjustDelegateEventSuccess

- (id)initWithTestLibrary:(ATLTestLibrary *)testLibrary {
    self = [super init];
    
    if (nil == self) {
        return nil;
    }
    
    self.testLibrary = testLibrary;
    
    return self;
}

- (void)adjustEventTrackingSucceeded:(ADJEventSuccess *)eventSuccessResponseData {
    NSLog(@"Event success callback called!");
    NSLog(@"Event success data: %@", eventSuccessResponseData);
    
    [self.testLibrary addInfoToSend:@"message" value:eventSuccessResponseData.message];
    [self.testLibrary addInfoToSend:@"timestamp" value:eventSuccessResponseData.timeStamp];
    [self.testLibrary addInfoToSend:@"adid" value:eventSuccessResponseData.adid];
    [self.testLibrary addInfoToSend:@"eventToken" value:eventSuccessResponseData.eventToken];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:eventSuccessResponseData.jsonResponse
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"Unable to conver NSDictionary with JSON response to JSON string: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self.testLibrary addInfoToSend:@"jsonResponse" value:jsonString];
    }
    
    [self.testLibrary sendInfoToServer];
}

@end