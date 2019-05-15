import Carbon

//
// Read ARGV[1]
//
let argv = CommandLine.arguments
if argv.count != 2 {
  print("usage: set-ime <name>");
  exit(1)
}
let desired_ime_name = argv[1]

//
// Lookup all available IMEs and find desired IME
//
var chosen_ime: TISInputSource? = nil
let ime_list = TISCreateInputSourceList(nil, false).takeRetainedValue() as! [TISInputSource]
for ime in ime_list {
  if let ime_name_ptr = TISGetInputSourceProperty(ime, kTISPropertyLocalizedName) {
    let ime_name = Unmanaged<AnyObject>.fromOpaque(ime_name_ptr).takeUnretainedValue() as! String
    if (desired_ime_name == ime_name) {
      chosen_ime = ime
      break
    }
  }
}

//
// Check if the lookup was successful
//
if chosen_ime == nil {
  print("Input source '\(desired_ime_name)' is not available")
  exit(1)
}

//
// Change IME
//
let err = TISSelectInputSource(chosen_ime)
if err != 0 {
  print("Could not change input language (OSStatus = \(err))")
  exit(1)
}
