const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// ProvidePlugin の設定（jQuery や Popper.js）
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)

module.exports = environment