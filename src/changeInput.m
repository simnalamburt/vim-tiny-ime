// changeInput
// Changes input language
//
// author:   Stefan Klieme (based on an idea by Craig Williams)
// created:  2009-11-05
// Usage:    changeInput                        prints current input language
//           changeInput    name                changes input language to name

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
