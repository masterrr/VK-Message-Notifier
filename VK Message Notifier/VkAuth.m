//
//  VkAuth.m
//  VK Message Notifier
//
//  Created by Dmitry Kurilo on 11/1/12.
//  Copyright (c) 2012 Kurilo Dmitry. All rights reserved.
//

#import "VkAuth.h"




@implementation VkAuth

- (void)webView:(WebView*)sender didFinishLoadForFrame:(WebFrame*)frame {
    // Gathering URL every time page loads
    NSString *url = frame.dataSource.request.URL.absoluteString;
    if ([url rangeOfString:@"access_token"].location != NSNotFound) {
        // URL Parsing for token and user uid
        NSArray *urlcomponents = [url componentsSeparatedByString:@"="];
        _token = [[[urlcomponents objectAtIndex:1] componentsSeparatedByString:@"&"] objectAtIndex:0];
        _uid = [urlcomponents lastObject];
        // calling - (void)didLogin in App.Deletage.h/m via loginProtocol
        if ([_delegate respondsToSelector:@selector(didLogin)]) {
            [_delegate didLogin];
        } 
    }
}

@end
