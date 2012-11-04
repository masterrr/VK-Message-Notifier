//
//  Menu.m
//  VK Message Notifier
//
//  Created by Dmitry Kurilo on 10/31/12.
//  Copyright (c) 2012 Kurilo Dmitry. All rights reserved.
//

#import "Menu.h"

@implementation Menu

// overriding init method
- (id)initTrayWithMenu:(NSMenu*)appmenu {
    self = [super init];
    if (self) {
        NSStatusBar *bar = [NSStatusBar systemStatusBar]; // defining NSStatusBar
        _theItem = [bar statusItemWithLength:NSVariableStatusItemLength]; // dynamic tray lenght, using @property (strong) NSStatusItem *theItem;
        [_theItem setEnabled:YES]; // reciever respond to click (menu)
        // @property (weak) IBOutlet NSMenu *trayMenu passed from AppDelegate from .xib
        [_theItem setMenu:appmenu];
        // Insted message counter until Appdelegate method checkmessages call our setMessage method
        [_theItem setTitle: @"-"];
    }
    return self;
}

- (void)setMessage:(NSString*)mess {
    [_theItem setTitle: mess];
}

@end

