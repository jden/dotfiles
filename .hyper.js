module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 14,

    // font family with optional fallbacks
    fontFamily: 'Source Code Pro',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: 'rgba(248,28,229,0.8)',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'UNDERLINE',

    // color of the text
    foregroundColor: 'rgba(0,205,46,0.9)',

    // terminal background color
    backgroundColor: '#000',

    // border color (window, tabs)
    borderColor: '#333',

    // custom css to embed in the main window
    css: '.footer_footer { opacity: 1 !important; }',

    // custom css to embed in the terminal window
    termCSS: '',

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: '12px 14px',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: '#000000',
      red: '#c91b00',
      green: '#00c200',
      yellow: '#c7c400',
      blue: '#0225c7',
      magenta: '#ca30c7',
      cyan: '#00c5c7',
      white: '#c7c7c7',
      lightBlack: '#686868',
      lightRed: '#ff6e67',
      lightGreen: '#5ffa68',
      lightYellow: '#fffc67',
      lightBlue: '#6871ff',
      lightMagenta: '#ff77ff',
      lightCyan: '#60fdff',
      lightWhite: '#ffffff'
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: false,

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg
  },

  // format: [@org/]project[#version]
  plugins: [
    'hyper-statusline',
    'hyperlinks-iterm',
    'hypercwd',
    'hyperterm-subpixel-antialiased',
    'hyper-tabs-enhanced'
  ],

  hyperStatusLine: {
    footerTransparent: false
  },

  hyperTabs: {
    trafficButtons: false,
    border: true,
    activityPulse: true
  },

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: []
}
