// ================================================================
// Copyright (C) 2008 Google Inc.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//      http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ================================================================
//
//  HelloController
//  HelloFS
//
//  Created by ted on 1/3/08.
//
#import "HelloController.h"
#import "HelloFuseFileSystem.h"
#import <OSXFUSE/OSXFUSE.h>

#include <signal.h>

@implementation HelloController

- (void)didMount:(NSNotification *)notification {
  NSDictionary* userInfo = [notification userInfo];
  NSString* mountPath = [userInfo objectForKey:kGMUserFileSystemMountPathKey];
#if defined (__APPLE__)
  NSString* parentPath = [mountPath stringByDeletingLastPathComponent];
  [[NSWorkspace sharedWorkspace] selectFile:mountPath
                   inFileViewerRootedAtPath:parentPath];
#else

/* Note: GNUstep's NSWorkspace class only supports GUI applications. Not command line applications */
	NSLog (@"Mounted HelloFS at '%@'", mountPath);
#endif	/* defined (__APPLE__) */
}

- (void)didUnmount:(NSNotification*)notification {
#if defined (__APPLE__)
  [[NSApplication sharedApplication] terminate:nil];
#else
	NSLog (@"Dismounted HelloFS");
	raise (SIGTERM);
#endif	/* defined (__APPLE__) */
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
  [center addObserver:self selector:@selector(didMount:)
                 name:kGMUserFileSystemDidMount object:nil];
  [center addObserver:self selector:@selector(didUnmount:)
                 name:kGMUserFileSystemDidUnmount object:nil];
  
  NSString* mountPath = @"/Volumes/Hello";
  HelloFuseFileSystem* hello = [[HelloFuseFileSystem alloc] init];
  fs_ = [[GMUserFileSystem alloc] initWithDelegate:hello isThreadSafe:YES];
  NSMutableArray* options = [NSMutableArray array];
#if defined (__APPLE__)
  [options addObject:@"rdonly"];
  [options addObject:@"volname=HelloFS"];
  [options addObject:[NSString stringWithFormat:@"volicon=%@",
    [[NSBundle mainBundle] pathForResource:@"Fuse" ofType:@"icns"]]];
#else
  [options addObject:@"ro"];
#endif	/* defined (__APPLE__) */
  [fs_ mountAtPath:mountPath withOptions:options];
}

#if defined (__APPLE__)

/* Note: GNUstep's NSApplication class only supports GUI applications. Not command line applications */

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [fs_ unmount];  // Just in case we need to unmount;
  [[fs_ delegate] release];  // Clean up HelloFS
  [fs_ release];
  return NSTerminateNow;
}

#endif	/* defined (__APPLE__) */

@end
