# Unreleased

- Running with the arg "-DISABLE_MUSIC" will now set the Menu Music option to false
- Running with the arg "-FORCE_DEVMODE" will now force developer mode

- If no songs are loaded via a text file then the Song Select will now set it's song list to "test" 
- The Song Select now displays it's song list depending on a `data/songs` file (default: `volume1` if it can)

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
