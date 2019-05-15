#import <Carbon/Carbon.h>

//
// Main logic
//
static int change_ime() {
  // Lookup all available IMEs
  NSArray *inputArray = (NSArray*)TISCreateInputSourceList(NULL, false);
  NSMutableDictionary *availableLanguages = [NSMutableDictionary dictionaryWithCapacity:[inputArray count]];
  for (NSUInteger i = 0; i < [inputArray count]; ++i) {
    NSString *name = TISGetInputSourceProperty(
        (TISInputSourceRef)[inputArray objectAtIndex:i],
        kTISPropertyLocalizedName);

    [availableLanguages setObject:[inputArray objectAtIndex:i] forKey:name];
  }
  [inputArray release];

  // Read ARGV[1]
  NSString *chosenInput = [[[NSProcessInfo processInfo] arguments] objectAtIndex:1];

  // Find desired IME
  TISInputSourceRef chosen = (TISInputSourceRef)[availableLanguages objectForKey:chosenInput];
  if (!chosen) {
    fprintf(stderr, "Input source '%s' is not available\n", [chosenInput UTF8String]);
    return 1;
  }

  // Change IME
  const OSStatus err = TISSelectInputSource(chosen);
  if (err) {
    fprintf(stderr, "Could not change input language (OSStatus = %i)\n", (int)err);
    return 1;
  }

  return 0;
}

//
// Entry point
//
int main(int argc, const char __attribute__((unused)) *argv[]) {
  if (argc < 2) { return 1; }

  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  const int ret = change_ime();
  [pool release];

  return ret;
}
