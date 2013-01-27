//
//  AppDelegate.m
//  VK Message Notifier
//
//  Created by Dmitry Kurilo on 10/31/12.
//  Copyright (c) 2012 Kurilo Dmitry. All rights reserved.
//

#import "AppDelegate.h"


// Create vk app here: http://vk.com/editapp?act=create

const int client_id = 5201106; // your client_id app's code here

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _men = [[Menu alloc] initTrayWithMenu:_trayMenu]; // Initializating (I've write custom init method) status bar icon w/ menu
    _vkAuth = [[VkAuth alloc] init];
    _defaults = [NSUserDefaults standardUserDefaults];
    if ([_defaults objectForKey:@"token"] && [_defaults objectForKey:@"uid"]) {
        [_window close];
        [_vkAuth setToken:[_defaults objectForKey:@"token"]];
        [_vkAuth setUid:[_defaults objectForKey:@"uid"]];
        [self startTimer];
    } else {
        // Seeting (@property (strong) id delegate) for calling back (via loginProtocol) when authorisation is done
        [_vkAuth setDelegate:self];
        // Frame load and we're calling delegate metod in _vkAuth (WebFrameLoadDelegate protocol)
        // calling (void)webView:(WebView*)sender didFinishLoadForFrame:(WebFrame*)frame via WebFrameLoadDelegate protocol
        [_vkWebView setFrameLoadDelegate:_vkAuth];
        [_vkWebView setMainFrameURL:[self generateLoginUrl]]; // Go to auth app page at the vk.com
    }
}

// Generating authorization URL for _vkWebView (IBOutlet). [up]
- (NSString *)generateLoginUrl {
    return [NSString stringWithFormat:@"http://api.vk.com/oauth/authorize?client_id=%d&scope=messages,offline&redirect_uri=http://api.vk.com/blank.html&display=touch&response_type=token", client_id];
}

// Method called from VkAuth.h after authorization is done
- (void)didLogin {
    [_window close];
    _defaults = [NSUserDefaults standardUserDefaults];
    [_defaults setObject:[_vkAuth token] forKey:@"token"];
    [_defaults setObject:[_vkAuth uid] forKey:@"uid"];
    [self startTimer]; // start timer, which will fired every (scheduledTimerWithTimeInterval) seconds and check user inbox
}

-(void)startTimer {
    [self checkMessages];
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

-(void) timerFired:(NSTimer *)theTimer { [self checkMessages]; } // everytime when timer fire we check user inbox via checkmessages timer

-(void) stopTimer { [_myTimer invalidate]; } // we don't really use this method, overengineering 

-(void)checkMessages {
    // Preparing string with future URL request. Filters — 1 makes clear to VK API that we want ONLY INBOX UNREAD messages
    NSString *reqURL = [[NSString alloc] initWithFormat:@"https://api.vk.com/method/messages.get?access_token=%@&filters=%@", [_vkAuth token], @"1"];
    NSLog(@"%@", reqURL);
    // I'm using such cachePolicy for preventing program to cache API answers. If somebody will wipe this property/feautre off program will cache every API request to your HDD. or SSD :)
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqURL] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60.0];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (response) {
        // Parsing response with SBJson framework
        // [@"response"] — main API answer frame, firstObject — number of INBOX UNDREAD messages
        _messageCounter = [[response JSONValue][@"response"] firstObject];
        [_men setMessage: _messageCounter]; // send to Menu.h/m class message that we want refresh the message counter in status bar
    }
    
}


@end
