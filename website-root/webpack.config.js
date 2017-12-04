// [ Moreira Development ] -----------
// SASS Boilerplate - Webpack.config
//
// Created on 27/10/2017 - LUM
//

// Imports and Constants
const {resolve} = require('path')
const webpack = require('webpack')
const BrowserSyncPlugin = require('browser-sync-webpack-plugin')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const {getIfUtils, removeEmpty} = require('webpack-config-utils')
const FaviconsWebpackPlugin = require('favicons-webpack-plugin');
const autoprefixer = require('autoprefixer')
const StyleLintPlugin = require('stylelint-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const WriteFilePlugin   = require('write-file-webpack-plugin')

const CURRENT_IP = require('my-local-ip')()
const externalPath = `http://${CURRENT_IP}:${process.env.WEBPACK_SERVER_PORT}/`
const {ifProduction, ifNotProduction, ifDevelopment} = getIfUtils(process.env.NODE_ENV)
const rootNodeModulesPath = resolve(__dirname, 'node_modules')

// [ THEME NAME ] ---------------------/
// Determines the name of the output folder
// that webpack will create to adhere to
// wordpress documentation.
const THEME_NAME        = 'rsp-awards'
exports.THEME_NAME      = THEME_NAME

// Generate Style Loader Order
const generateStyleLoaders = (...loaders) => (
  loaders.map(loader => (
    {
      loader,
      options: {
        sourceMap: !!process.env.SOURCE_MAP
      }
    }
  ))
)

// [ generateHtml ] ------------------------
// Generates new calls to html-webpack-plugin
// allowing the compilation of new templates.
const generateHtml = (bundleName,templateName) => (

   new HtmlWebpackPlugin({
      chunksSortMode: 'dependency',
      inject: true,
      chunks: [bundleName],
      template: './' + templateName,
      filename: templateName,
      minify: ifProduction({
        removeComments: true,
        collapseWhitespace: true,
        keepClosingSlash: true,
        minifyJS: true,
        minifyCSS: true,
        minifyURLs: true
      })
    })
)


// Webpack Configuration
module.exports = {
  context: resolve(__dirname, 'src'),
  devtool: ifProduction(!!process.env.SOURCE_MAP && 'source-map', 'cheap-module-eval-source-map'),
  stats: {
    colors: true,
    children: false,
    chunks: true,
    chunkModules: true,
    modules: false
  },
  devServer: {
    historyApiFallback: true,
    noInfo: true
  },
  // [ ENTRY ] -----------------------/
  // Entry indicates to webpack how many
  // webpages and JS files it needs to output.
  // You must add a new entry per page, each page
  // should have it's own app/[pagename].js
  // with it's own imports.
  entry: {
    index: 'src/app/index.js',
    page2: 'src/app/page2.js'
  },
  resolve: {
    alias: {
      'src': resolve(__dirname, 'src'),
      'app': resolve(__dirname, 'src/app'),
      'styles': resolve(__dirname, 'src/styles'),
      'lib': resolve(__dirname, 'src/js')
    },
    modules: ['node_modules', 'shared']
  },
  // [ OUTPUT ] ----------------------/
  // Configuration for how Webpack is going
  // to output the files for the server.
  // Each entry above will get it's own
  // named Bundle.
  output: {
    publicPath: '/',
    filename: 'js/bundle-[name].js',
    chunkFilename: 'js/chunk.[name].js',
    // Output path points to theme name
    path: resolve(__dirname, THEME_NAME),
    pathinfo: ifNotProduction()
  },
  // [ MODULES ] ---------------------/
  module: {
    rules: [
      // [ JS PROCESSING ] ---------------------/
      {
        test: /\.js$/,
        enforce: 'pre',
        loader: 'eslint-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.js$/,
        loader: 'babel-loader',
        exclude: /node_modules/,
        options: {
          cacheDirectory: ifDevelopment()
        }
      },
      // [ STYLES PROCESSING ] ----------------/
      {
        test: /\.css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: generateStyleLoaders('css-loader', 'postcss-loader')
        })
      },
      {
        test: /\.scss$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: generateStyleLoaders('css-loader', 'postcss-loader', 'sass-loader')
        })
      },
      // [ IMAGE PROCESSING ] ---------------------/
      {
        test: /\.(png|jpg|jpeg|gif|svg)$/,
        loaders: [ 'file-loader?context=src/img&name=img/[path][name].[ext]', {
          loader: 'image-webpack-loader',
          query: {
            mozjpeg: {
              progressive: true,
              quality: 95
            },
            gifsicle: {
              interlaced: false,
              optimizationLevel: 2
            },
            pngquant: {
              quality: '50-80',
              speed: 3
            },
            svgo: {
              plugins: [
                {
                  removeViewBox: false
                },
                {
                  removeEmptyAttrs: false
                }
              ]
            }
          }

        }]
      },
      // [ FONT PROCESSING ] --------------------/
      {
        test: /\.eot(\?.*)?$/,
        loader: 'url-loader',
        options: {
          limit: 10000,
          mimetype: 'application/vnd.ms-fontobject',
          name: 'fonts/[name].[ext]',
        }
      },
      {
        test: /\.otf(\?.*)?$/,
        loader: 'url-loader',
        options: {
          limit: 10000,
          mimetype: 'font/opentype',
          name: 'fonts/[name].[ext]',
        }
      },
      {
        test: /\.ttf(\?v=\d+.\d+.\d+)?$/,
        loader: 'url-loader',
        options: {
          limit: 10000,
          mimetype: 'application/octet-stream',
          name: 'fonts/[name].[ext]',
        }
      },
      {
        test: /\.woff(\?.*)?$/,
        loader: 'url-loader',
        options: {
          limit: 10000,
          mimetype: 'application/font-woff',
          name: 'fonts/[name].[ext]',
        }
      },
      {
        test: /\.woff2(\?.*)?$/,
        loader: 'url-loader',
        options: {
          limit: 10000,
          mimetype: 'application/font-woff2',
          name: 'fonts/[name].[ext]',
        }
      }
    ]
  },
  // [ PLUGINS ] --------------------/
  plugins: removeEmpty([
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: ifDevelopment('"development"', '"production"')
      }
    }),

    new webpack.LoaderOptionsPlugin({
      minimize: ifProduction(),
      debug: ifNotProduction()
    }),

    new StyleLintPlugin({
      syntax: 'scss'
    }),
    ifDevelopment(new webpack.HotModuleReplacementPlugin()),
    ifDevelopment(new webpack.NoEmitOnErrorsPlugin()),
    ifNotProduction(new webpack.NamedModulesPlugin()),

    ifProduction(
      new webpack.optimize.UglifyJsPlugin({
        sourceMap: !!process.env.SOURCE_MAP,
        compress: {
          screw_ie8: true,
          warnings: false
        },
        mangle: {
          screw_ie8: true
        },
        output: {
          comments: false,
          screw_ie8: true
        }
      })
    ),

    new ExtractTextPlugin({
      filename: 'css/styles.css'
    }),
    // [ HTML OUTPUT ] ---------------
    // To get webpack to output HTML
    // you must tell it which template to use and
    // which Javascript bundle to correspond to.
    //
    // [generateHtml]----------------
    // generateHtml is a helper that genrates calls to
    // html-webpack-plugin with all the necessary
    // paramaters. All you have to do is call one
    // per template you want to compile and give it
    // the matching entrypoint and template
    //
    // [ USAGE ]------------------
    // generateHtml('entry', 'template.html'),
    //
    generateHtml('index','index.html'),
    generateHtml('page2','page2.html'),
    // [ FAVICON PROCESSING ] --------
    new FaviconsWebpackPlugin({
      logo: 'src/img/favicon.png',
      prefix: 'icons/',
      emitStats: false,
      persistentCache: true,
      inject: true,
      background: '#fff',
      title: 'HTML 5 Boilerplate',

      icons: {
        android: true,
        appleIcon: true,
        appleStartup: true,
        coast: false,
        favicons: true,
        firefox: true,
        opengraph: false,
        twitter: false,
        yandex: false,
        windows: false
      }
    }),
    // [ PHP OUTPUT ] ----------------
    // Webpack is using the Copy Webpack Plugin
    // to essentially copy raw PHP files from the
    // php folder. That means that Webpack is not able to
    // inject any Style / Script tags so those must be added
    // manually according to the /dist output folder.
    new CopyWebpackPlugin([
      { from: 'php', to: __dirname + '/' + THEME_NAME },
      { from: 'themeinfo', to: __dirname + '/' + THEME_NAME }
    ]),

    process.env.BROWSER_SYNC && ifNotProduction(
      new BrowserSyncPlugin({
        open: false,
        port: process.env.BROWSER_SYNC_PORT,
        proxy: externalPath
      }, {
        // prevent BrowserSync from reloading the page
        // and let Webpack Dev Server take care of this
        reload: false
      })
    ),
  ])
}
