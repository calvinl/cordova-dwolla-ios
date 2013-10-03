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

@synthesize callbackIds = _callbackIds;

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
    APIViewController* actions = [[APIViewController alloc] init];
    [actions setModalPresentationStyle: UIModalPresentationFullScreen];
    [self.viewController presentViewController:actions animated:YES completion:nil];

}

-(void)failedLogin:(NSArray*)errors
{
    NSLog(@"failedLogin");
}

@end

