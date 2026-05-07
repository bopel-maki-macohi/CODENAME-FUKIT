# 1.2.1 - 5/7/2026

## Songs

- STAR PROGRAM : Bf and Alikit speed away now at the end of the song

## Song Select Menu

- Added Score text
- The mouse is now hidden
- Song metadata is now loaded correctly
- Songs prefixed with an underscore in the loaded song list will be checked for a (non-zero) highscore before being added as a text
- If no songs are loaded via a text file then the song list will be set to "test"
- The Song list is now dependent on a `data/songs` file instead of one song list file (default: `volume1` if it can)

## PC Menu

- Fixed missing transition in from the PC Menu when the intro length has been extended

## Misc

- Fixed flicker of "freakyMenu" when leaving a song via the pause menu
  - I might be losing it but I heard a flicker of it

- Fixed Music (when enabled) stopping when selecting an options sub menu
- All Haxe / Script files have been cleaned up!
  - The state scripts changed the most

- All Haxe / Script files are formatted now
  - The hxformat.json resulting in the formatting is included in the mod

- New Arguments:
  - `-FORCE_DEVMODE` : Forces Developer mode
  - `-SKIP_INTRO` : Skips the intro state

# 1.2 - 5/6/2026

- **Added RAM ROB Song!**
- **Added STAR PROGRAM Song!**
  - First song with dialogue!

- [oxipng](https://github.com/oxipng/oxipng) has been run on all png files
  - This is not threaded (import doesn't work) so it will cause lag
  - an oxipng command now runs if it detects a ".dev" folder in the mod directory
    - Can be disabled by running the codename engine executable with the arg "NO_OXIPNG"
      - I added an entire arg system just for this one thing, but hey it can be used for other cool things too!

- The FPS / Debug display is disabled by default when openning CNE and this is the loaded mod
- Added Option to toggle cutscenes
- Fixed FreakyMenu playing when moving to and out the Gameplay menu in the options menu
- Fixed flickers of "FreakyMenu" appearing in places when the Menu Music is disabled
- NyxTheShield is now credited in the credits menu
- The Folir icon is now shifted up
- Changed how the difficulty stars bounce when they change

# 1.1 - 5/5/2026

- **Added LAVA PROTOCOL Song!**

- The mod name & version are displayed on the main pc screen
- The mod API_VERSION is now 2
  - Sustains are now counted as one note
  - Legacy zoom factor is no longer used
  - Legacy timing is no longer used

- Arpe now has a little (fake) visualizer on his chest when doing the "HEY!!" in Greenland (No visualizer anims for when he's mimicing bf's beepboxing)
- Added Song Star Difficulty display in the songs folder menu

- Added Codename Fukit Options page
  - Added option to disable menu music

- The mod download is now in the config

# 1.0 - 5/5/2026

Inital Release
