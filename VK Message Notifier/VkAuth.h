//
//  VkAuth.h
//  VK Message Notifier
//
//  Created by Dmitry Kurilo on 11/1/12.
//  Copyright (c) 2012 Kurilo Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "authProtocol.h"

@interface VkAuth : NSObject

@property (weak) NSString *token;
@property (weak) NSString *uid;
@property (strong) id delegate;

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame;

@end
