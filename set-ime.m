#import <Carbon/Carbon.h>

int main() {
  @autoreleasepool {
    //
    // Read ARGV[1]
    //
    NSArray<NSString*> *argv = [[NSProcessInfo processInfo] arguments];
    if ([argv count] != 2) { return 1; }
    NSString *desired_ime_name = argv[1];

    //
    // Lookup all available IMEs and find desired IME
    //
    TISInputSourceRef chosen_ime = nil;
    NSArray *ime_list = (NSArray*)TISCreateInputSourceList(nil, false);
    for (id elem in ime_list) {
      TISInputSourceRef ime = (TISInputSourceRef)elem;
      NSString *ime_name = TISGetInputSourceProperty(ime, kTISPropertyLocalizedName);

      if ([desired_ime_name isEqualToString:ime_name]) {
        chosen_ime = ime;
        break;
      }
    }

    //
    // Check if the lookup was successful
    //
    if (!chosen_ime) {
      fprintf(stderr, "Input source '%s' is not available\n", [desired_ime_name UTF8String]);
      return 1;
    }

    //
    // Change IME
    //
    const OSStatus err = TISSelectInputSource(chosen_ime);
    if (err) {
      fprintf(stderr, "Could not change input language (OSStatus = %i)\n", (int)err);
      return 1;
    }
  }
}
