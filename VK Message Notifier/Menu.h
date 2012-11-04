//
//  Menu.h
//  VK Message Notifier
//
//  Created by Dmitry Kurilo on 10/31/12.
//  Copyright (c) 2012 Kurilo Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject
@property (strong) NSStatusItem *theItem;
@property (strong) NSImage *noMessages;
@property (strong) NSImage *haveMessages;


- (id)initTrayWithMenu:(NSMenu*)appmenu;
- (void)setMessage:(NSString*)mess;
@end
