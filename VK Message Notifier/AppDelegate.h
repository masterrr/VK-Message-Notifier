//
//  AppDelegate.h
//  VK Message Notifier
//
//  Created by Dmitry Kurilo on 10/31/12.
//  Copyright (c) 2012 Kurilo Dmitry. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "Menu.h"
#import "VkAuth.h"
#import "SBJson.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, loginProtocol>
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet WebView *vkWebView;
@property (strong) VkAuth *vkAuth;
@property (strong) Menu *men;
@property (weak) NSTimer *myTimer;
@property (weak) NSString *messageCounter;
@property (strong) NSUserDefaults *defaults; 

@property (weak) IBOutlet NSMenu *trayMenu;

- (NSString *) generateLoginUrl;
- (void) didLogin;
- (void) checkMessages;

-(void) startTimer;
-(void) stopTimer;
-(void) timerFired:(NSTimer*)theTimer;


@end
