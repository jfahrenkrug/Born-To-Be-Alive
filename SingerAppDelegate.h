//
//  SingerAppDelegate.h
//  Singer
//
//  Created by Johannes Fahrenkrug on 29.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SingerAppDelegate : NSObject <NSApplicationDelegate, NSSpeechSynthesizerDelegate> {
    NSWindow *window;
	IBOutlet NSImageView *imageView;
	IBOutlet NSButton *startButton;
	IBOutlet NSButton *stopButton;
	IBOutlet NSPopUpButton *voiceList;
	NSImage *openImage;
	NSImage *closedImage;
	NSSpeechSynthesizer *ns;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;

@end
