//
//  DwollaOauthPlugin.m
//  Helper
//
//  Created by Calvin Lai on 7/17/13.
//
//

#import "DwollaOauthPlugin.h"
#import <Cordova/CDVViewController.h>
#import <Cordova/CDVDebug.h>


@implementation DwollaOauthPlugin

@synthesize callbackIds = _callbackIds, oAuthTokenRepository;

- (NSMutableDictionary*)callbackIds {
	if(_callbackIds == nil) {
		_callbackIds = [[NSMutableDictionary alloc] init];
	}
	return _callbackIds;
}

- (void)login:(CDVInvokedUrlCommand*)command {
    NSLog(@"compose:%@", command.arguments);
    
    [self.callbackIds setValue:command.callbackId forKey:@"compose"];
    
    //NSDictionary *options = [command.arguments objectAtIndex:0];
    
    NSArray *scopes = [[NSArray alloc] initWithObjects:@"send", @"balance", @"accountinfofull", @"contacts", @"funding",  @"request", @"transactions", nil];
    DwollaOAuth2Client *client = [[DwollaOAuth2Client alloc] initWithFrame:CGRectMake(0, 0, 320, 460)
                                                                       key:@"yourkey"
                                                                    secret:@"yoursecret"
                                                                  redirect:@"https://www.dwolla.com"
                                                                  response:@"code"
                                                                    scopes:scopes
                                                                      view:self.viewController.view
                                                                  reciever:self];
    [client login];

}

-(void)successfulLogin
{
    oAuthTokenRepository = [[OAuthTokenRepository alloc] init];

    NSString *oAuthToken = [oAuthTokenRepository getAccessToken];
    if (oAuthToken != (id)[NSNull null] && oAuthToken.length != 0 ) {

        NSLog(@"oauth token: %@", [oAuthTokenRepository getAccessToken]);

        NSMutableDictionary *results = [NSMutableDictionary dictionary];
        [results setObject: oAuthToken forKey: @"token"];

        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:results];
        [self writeJavascript:[pluginResult toSuccessCallbackString:[self.callbackIds valueForKey:@"login"]]];

    } else {

        NSMutableDictionary *results = [NSMutableDictionary dictionary];
        [results setValue:[NSString stringWithFormat:@"%@", @"Error retrieving oAuthToken."] forKey:@"error"];

        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:results];
        [self writeJavascript:[pluginResult toErrorCallbackString:[self.callbackIds valueForKey:@"login"]]];

    }
}

-(void)failedLogin:(NSArray*)errors
{
    NSLog(@"failedLogin");
}

@end

