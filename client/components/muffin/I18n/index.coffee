# Recursively merge two objects
deepMerge = (src, target) ->
  for k, v of src
    if typeof v is 'object'
      target[k] ?= {}
      deepMerge target[k], v
    else
      target[k] = v
  target

# Localization
class I18n

  constructor: ->
    # The currently selected locale. Call `setLocale` to change it.
    @locale = null

    # The app might set a default locale that provides the base strings.
    @defaultLocale = null

    # We need a list of supported locales because we might need to find a
    # best match for a given locale. For example, the browser locale might
    # be `en-US`, which will be matched to `en`.
    @supportedLocales = []

    # Mapping string ids to localized strings.
    @mapping = {}

  # Detect the browser locale
  getBrowserLocale: ->
    if navigator
      locale = navigator.language or navigator.browserLanguage or navigator.systemLanguage or navigator.userLanguage
      locale = locale.replace('_', '-').replace(/\W/, '-').toLowerCase() if locale
    locale ?= 'en'
    locale

  # By convention, all the strings files reside in `strings/#{locale}/str.coffee`.
  pathForLocale: (locale) ->
    "strings/#{locale}/str"

  # Set locale
  setLocale: (locale, done) ->
    # `paths` stores the file paths of all strings files to load.
    paths = []

    # If the default locale is set, load it first.
    if @defaultLocale
      path = @pathForLocale(@defaultLocale)
      paths.push path

    # If the supportedLocales is set, find the best fit for the locale.
    if @supportedLocales.length > 0
      parts = locale.split('-')
      for i in [0...parts.length]
        current = parts[0..i].join('-')
        if current in @supportedLocales
          @locale = current
          path = @pathForLocale(current)
          paths.push(path) unless path in paths
    else
      @locale = locale
      path = @pathForLocale(locale)
      paths.push path

    # If `paths` is empty, set the locale to `en`.
    if paths.length is 0
      @locale = 'en'
      paths.push @pathForLocale('en')

    # Asynchronously load the strings files.
    require paths, =>
      # Reset the strings map
      @clear()

      # Register localized strings
      for path in paths
        str = require path
        @register str

      # All done
      done()

  # Register localized strings
  register: (mapping) ->
    deepMerge mapping, @mapping

  # Clear the strings map
  clear: ->
    @mapping = {}

  # Get the localized string from a string id.
  # Support string ids in dot notation, like 'a.b.c'.
  # Support string interpolation via underscore template.
  t: (stringId, context={}) ->
    str = @mapping
    _(stringId.split('.')).each (part) -> str = str[part]
    if str?
      _.template(str)(context)
    else
      console.error "Can't find '#{stringId}' in the strings file."
      undefined

module.exports = new I18n()
