#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

int main(int argc, const char* __attribute__((unused)) argv[]) {
  NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

  if (argc == 1) {
    TISInputSourceRef current = TISCopyCurrentKeyboardInputSource();
    NSString* currentName = TISGetInputSourceProperty(current, kTISPropertyLocalizedName);
    printf("%s\n", [currentName UTF8String]);
    CFRelease(current);
  } else {
    NSArray* inputArray = (NSArray*)TISCreateInputSourceList(NULL, false);
    NSMutableDictionary* availableLanguages = [NSMutableDictionary dictionaryWithCapacity:[inputArray count]];
    for (NSUInteger i = 0; i < [inputArray count]; ++i) {
      const void *name = TISGetInputSourceProperty(
          (TISInputSourceRef)[inputArray objectAtIndex:i],
          kTISPropertyLocalizedName);

      [availableLanguages setObject:[inputArray objectAtIndex:i] forKey:name];
    }
    [inputArray release];

    NSString *chosenInput = [[[NSProcessInfo processInfo] arguments] objectAtIndex:1];
    TISInputSourceRef chosen = (TISInputSourceRef)[availableLanguages objectForKey:chosenInput];
    if (chosen) {
      OSStatus err = TISSelectInputSource(chosen);
      if (err) {
        printf("Could not change input language (error %i)\n", (int)err);
      } else {
        printf("Changed input language to %s\n", [chosenInput UTF8String]);
      }
    } else {
      printf("%s not available\n", [chosenInput UTF8String]);
    }
  }

  [pool release];
}
