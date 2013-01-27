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
    NSString *url = frame.dataSource.request.URL.absoluteString;
    if ([url rangeOfString:@"access_token"].location != NSNotFound) {
        NSArray *urlcomponents = [url componentsSeparatedByString:@"="];
        _token = [[[urlcomponents objectAtIndex:1] componentsSeparatedByString:@"&"] objectAtIndex:0];
        _uid = [urlcomponents lastObject];
        if ([_delegate respondsToSelector:@selector(didLogin)]) {
            [_delegate didLogin];
        } 
    } else {
        if ([_delegate respondsToSelector:@selector(errorHandler)]) {
            // TODO
        }
    }
}

@end
