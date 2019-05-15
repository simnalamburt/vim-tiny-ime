// changeInput
// Changes input language
//
// author:   Stefan Klieme (based on an idea by Craig Williams)
// created:  2009-11-05
// Usage:    changeInput                        prints current input language
//           changeInput    name                changes input language to name
//           changeInput    toggle name1 name2  toggles input language between
//                                              name1 and name2

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

int main(int argc, const char* argv[]) {
  NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];

  NSArray* args = [[NSProcessInfo processInfo] arguments];
  TISInputSourceRef current = TISCopyCurrentKeyboardInputSource();
  NSString* currentName = (NSString *)TISGetInputSourceProperty(current, kTISPropertyLocalizedName);
  if (argc == 1) {
    printf("%s\n", [currentName UTF8String]);
  } else {
    NSString *chosenInput, *language1, *language2;
    NSArray* inputArray = (NSArray*)TISCreateInputSourceList(NULL, false);
    NSMutableDictionary* availableLanguages = [NSMutableDictionary dictionaryWithCapacity:[inputArray count]];
    NSUInteger i;
    TISInputSourceRef chosen, languageRef1, languageRef2;
    for (i = 0; i < [inputArray count]; ++i) {
      [availableLanguages setObject:[inputArray objectAtIndex:i] forKey:TISGetInputSourceProperty((TISInputSourceRef)[inputArray objectAtIndex:i], kTISPropertyLocalizedName)];
    }
    [inputArray release];

    if (argc == 4 && [[args objectAtIndex:1] isEqualTo:@"toggle"]) {
      language1 = [args objectAtIndex:2];
      language2 = [args objectAtIndex:3];
      languageRef1 = (TISInputSourceRef)[availableLanguages objectForKey:language1];
      languageRef2 = (TISInputSourceRef)[availableLanguages objectForKey:language2];
      if (languageRef1 != nil && languageRef2 != nil) {
        chosenInput = ([language1 isEqualTo:currentName]) ? language2 : language1;
        chosen = (TISInputSourceRef)[availableLanguages objectForKey:chosenInput];
      } else {
        chosenInput = (languageRef1 == nil) ? language1 : language2;
        chosen = nil;
      }
    } else {
      chosenInput = [args objectAtIndex:1];
      chosen = (TISInputSourceRef)[availableLanguages objectForKey:chosenInput];
    }
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
  CFRelease(current);
  [pool release];
  return 0;
}
