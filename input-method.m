#import <Carbon/Carbon.h>

//
// Main logic
//
static int change_ime() {
  // Read ARGV[1]
  NSString *desired_ime_name = [[[NSProcessInfo processInfo] arguments] objectAtIndex:1];

  // Lookup all available IMEs and fined desired IME
  TISInputSourceRef chosen_ime = nil;
  NSArray *ime_list = (NSArray*)TISCreateInputSourceList(NULL, false);
  for (NSUInteger i = 0; i < [ime_list count]; ++i) {
    TISInputSourceRef ime = (TISInputSourceRef)[ime_list objectAtIndex:i];
    NSString *ime_name = TISGetInputSourceProperty(ime, kTISPropertyLocalizedName);
    if ([desired_ime_name isEqualToString:ime_name]) {
      chosen_ime = ime;
      break;
    }
  }
  [ime_list release];

  // Find desired IME
  if (!chosen_ime) {
    fprintf(stderr, "Input source '%s' is not available\n", [desired_ime_name UTF8String]);
    return 1;
  }

  // Change IME
  const OSStatus err = TISSelectInputSource(chosen_ime);
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
