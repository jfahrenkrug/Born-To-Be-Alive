//
//  SingerAppDelegate.m
//  Singer
//
//  Created by Johannes Fahrenkrug on 29.09.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SingerAppDelegate.h"

@interface SingerAppDelegate(PrivateMethods)
- (NSArray *)getSpeechVoices;
- (void)enableUI:(BOOL)enable;
@end


@implementation SingerAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[voiceList removeAllItems];
	[voiceList addItemsWithTitles:[self getSpeechVoices]];
	
	openImage = [NSImage imageNamed:@"open"];
	closedImage = [NSImage imageNamed:@"closed"];
	
	ns = [[NSSpeechSynthesizer alloc] init];
	ns.delegate = self;
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender willSpeakWord:(NSRange)wordToSpeak ofString:(NSString *)text {
	if (imageView.image == closedImage) {
		imageView.image = openImage;
	} else {
		imageView.image = closedImage;
	}
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)success {
	[self enableUI:YES];
}

- (void)enableUI:(BOOL)enable {
	[startButton setEnabled:enable];
	[voiceList setEnabled:enable];
	[stopButton setEnabled:!enable];
}

- (NSArray *)getSpeechVoices {
	NSMutableArray *voices = [[NSMutableArray alloc] init];
	
	for (NSString * longVoice in [NSSpeechSynthesizer availableVoices]) {
		[voices addObject:[longVoice pathExtension]];
	}
	
	return voices;
}

- (IBAction)start:(id)sender {
	NSString *voiceID =[[NSSpeechSynthesizer availableVoices] objectAtIndex:[voiceList indexOfSelectedItem]];
    [ns setVoice:voiceID];
	
	[self enableUI:NO];
	
	[ns startSpeakingString:@"[[emph +; pbas 50; rate 200]]We [[pbas 30]]were born to [[emph +; pbas 50]]be [[slnc 300]] [[emph +; rate 130; pbas 50]]a lie i've! \
	 [[emph +; pbas 50; rate 200]]We [[pbas 30]]were born to [[emph +; pbas 50]]be [[slnc 300]] [[emph +; rate 130; pbas 50]]a lie i've![[pbas 40; rate 80]]Born, \
	 [[rset 0]]born to be alive. You see we're [[slnc 100]][[pbas 40; rate 100]]born, [[pbas 35; rate 100]]born, [[pbas 30; rate 100]]born, [[rset 0]]born to [[emph +]]be [[emph -]]alive. \
	 [[rate 220]]People ask me [[emph +]]why [[slnc 50]]I never find a place to stop and settle [[emph +]]down down down. \
	 But I never wanted all those things. People need to justify their [[emph +]]lives lives lifes. \
	 [[rset 0]]You see you were [[slnc 100]][[pbas 40; rate 100]]born, [[pbas 35; rate 100]]born, [[pbas 30; rate 100]]born. [[rset 0]]Born to [[emph +]]be [[emph -]]alive."];
}

- (IBAction)stop:(id)sender {
	[ns stopSpeaking];
	[self enableUI:YES];
}

@end
