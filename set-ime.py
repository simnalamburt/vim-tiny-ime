#!/usr/bin/python
import sys
import objc
import Foundation

#
# Read ARGV[1]
#
if len(sys.argv) != 2:
    print 'usage: set-ime <name>'
    sys.exit(1)
desired_ime_name = sys.argv[1]

#
# Load carbon framework
#
carbon = {}

bundle = Foundation.NSBundle.bundleWithIdentifier_('com.apple.HIToolbox')
objc.loadBundleFunctions(bundle, carbon, [
    ('TISCreateInputSourceList','@@B'),
    ('TISGetInputSourceProperty', '@@@'),
    ('TISSelectInputSource', 'I@'),
])
objc.loadBundleVariables(bundle, carbon, [
    ('kTISPropertyLocalizedName', '@'),
])

#
# Lookup all available IMEs and find desired IME
#
for ime in carbon['TISCreateInputSourceList'](None, False):
    ime_name = carbon['TISGetInputSourceProperty'](ime, carbon['kTISPropertyLocalizedName'])
    if desired_ime_name == ime_name:
        chosen_ime = ime
        break
else:
    print 'Input source "{}" is not available'.format(desired_ime_name)
    sys.exit(1)

#
# Change IME
#
err = carbon['TISSelectInputSource'](chosen_ime)
if err != 0:
    print 'Could not change input language (OSStatus = {})'.format(err)
    sys.exit(1)
