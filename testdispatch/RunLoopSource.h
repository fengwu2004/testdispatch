#import <Foundation/Foundation.h>

@interface RunLoopSource : NSObject

@property(nonatomic) CFRunLoopSourceRef runloopSource;

@property(nonatomic) NSMutableArray *commands;

- (id)init;

- (void)addToCurrentRunLoop;

- (void)invalidate;

- (void)sourceFired;

- (void)addCommand:(NSInteger)command withData:(id)data;

- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop;

@end

void RunLoopSourceScheduleRoutine(void *info, CFRunLoopRef rl, CFStringRef mode);

void RunLoopSourcePerformRoutine(void *info);

void RunLoopSourceCancelRoutine(void *info, CFRunLoopRef rl, CFStringRef mode);
