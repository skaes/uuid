#!/usr/bin/ruby

require 'mkmf'

if RUBY_PLATFORM =~ /darwin/
  if !have_header('uuid/uuid.h')
    puts <<-TEXT
      Unable to find uuid headers.
      Maybe you don't have Xcode tools installed?
    TEXT
    exit 1
  end
elsif have_header('uuid/uuid.h') && have_library('uuid')
  $CFLAGS = "-std=c99"
else
  puts <<-TEXT
    Unable to find uuid development library.
    Try sudo apt-get install uuid-dev
  TEXT
  exit 1
end

# OS X doesn't have this method, so test for it
have_func("uuid_variant")

create_makefile 'uuid'
