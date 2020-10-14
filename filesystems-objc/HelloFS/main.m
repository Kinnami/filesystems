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
//  main.m
//  HelloFS
//
//  Created by ted on 1/3/08.
//
#if defined (__APPLE__)
#import <Cocoa/Cocoa.h>
#else
#if defined (GNUSTEP)
#import <Foundation/Foundation.h>
#import <OSXFUSE/OSXFUSE.h>
#import "HelloFuseFileSystem.h"
#else
#error "Needs implementation"
#endif	/* defined (GNUSTEP) */
#endif	/* defined (__APPLE__) */


int main(int argc, char *argv[])
{
#if defined (__APPLE__)
    return NSApplicationMain(argc,  (const char **) argv);
#else

/* Note: GNUstep's NSApplication class only supports GUI applications. Not command line applications */
	NSAutoreleasePool *	poAutoreleasePool;

	poAutoreleasePool = [[NSAutoreleasePool alloc] init];

#if 0
	NSRunLoop *			poRunLoop;

	poRunLoop = [NSRunLoop mainRunLoop];
	[poRunLoop run];

#else
  GMUserFileSystem* fs_;
  NSString* mountPath = @"/Volumes/Hello";
  HelloFuseFileSystem* hello = [[HelloFuseFileSystem alloc] init];
  fs_ = [[GMUserFileSystem alloc] initWithDelegate:hello isThreadSafe:YES];
  NSMutableArray* options = [NSMutableArray array];
  [options addObject:@"ro"];
  [fs_ mountAtPath:mountPath withOptions:options shouldForeground: YES detachNewThread: NO];	/* Note: shouldForeground: YES: Debug output is sent to stderr */
#endif

	[poAutoreleasePool release];
	return 0;
#endif	/* defined (__APPLE__) */
}
