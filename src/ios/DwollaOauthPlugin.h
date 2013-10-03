//
//  DwollaOauth.h
//
//  Created by Calvin Lai on 8/11/13.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "DwollaOAuth2Client.h"
#import "IDwollaMessages.h"
#import "APIViewController.h"

@interface DwollaOauthPlugin : CDVPlugin <IDwollaMessages> {

  NSMutableDictionary* callbackIds;

}

@property (nonatomic, retain) NSMutableDictionary* callbackIds;

- (void)login:(CDVInvokedUrlCommand*)command;

-(void)successfulLogin;

-(void)failedLogin:(NSArray*)errors;

@end
