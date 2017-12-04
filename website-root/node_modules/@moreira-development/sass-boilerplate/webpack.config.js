// [ Moreira Development ] -----------
// SASS Boilerplate - Webpack.config
//
// Created on 27/10/2017 - LUM
//

const {resolve} = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const StyleLintPlugin = require('stylelint-webpack-plugin');
const autoprefixer = require('autoprefixer');

const config = {

  entry: './index.js',

  output: {
    path: resolve(__dirname, 'dist'),
    filename: 'build.js'
  },

  // Modules
  module: {
    rules: [
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: "style-loader",
          use: "to-string!css-loader?minimize&-autoprefixer!postcss-loader!sass-loader"
        })
      },
      {
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: "style-loader",
          use: [
            { loader: 'css-loader?minimize&-autoprefixer!postcss-loader!sass-loader' },
            { loader: 'sass-loader'},
            { loader: 'postcss-loader'}
          ]
        })
      }

    ]
  },

  //plugins
  plugins: [
    new webpack.LoaderOptionsPlugin({ options: { postcss: [ autoprefixer ]  } }),
    new ExtractTextPlugin("/compiled/styles.css"),
    new StyleLintPlugin({
      syntax: 'scss',
      configFile: './.stylelintrc'
    })
  ]
};

module.exports = config;
