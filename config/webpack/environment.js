const { environment } = require('@rails/webpacker')

environment.loaders.append('hbs', {
  test: /\.hbs$/,
  use: 'handlebars-loader'
})

module.exports = environment
