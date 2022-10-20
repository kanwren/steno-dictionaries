{ pkgs
, emily-modifiers
, emily-symbols
}:

# The order that dictionaries should appear, in order from highest to lowest
# priority
[
  ./static-dicts/uni-number-reversals.json
  "${emily-modifiers}/emily-modifiers.py"
  "${emily-symbols}/emily-symbols.py"
  ./static-dicts/commands.json
  ./static-dicts/main.json
]
