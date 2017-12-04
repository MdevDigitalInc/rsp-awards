![Moreira Development](http://moreiradevelopment.io/social/googleLogo.png)

# HTML5 Website Boilerplate
## How to use the Mdev HTML5 Boilerplate
The purpose of this Boilerplate is to deploy future ready static HTML5 websites with the power of modern web pipeline.
Assets will be exported, optimized and minified automatically as long as you follow the project structure.

### Running Project Locally
1. Before you run the project you must make sure you are logged in to your NPM account.
... To do so you must run the login command and enter the Username and Password you created for your NPM account. If you don't have one please contact a superior.

```bash
# Run NPM Login
npm login

# Enter Username
# Enter Password
# Enter Public Email
```


2. To run the project locally execute the setup script located at from the repository *root* directory:
```
./setup/dev-environment.sh
```

The script will install all the necessary dependencies to run the project and instantiate a local server with hot reloading.

3. Setup the local Nginx server if you have never done it before.
```bash
./setup/nginx-local-install.sh
```
---

#  Input Folder Structure
```bash
├── app
│   ├── index.js
│   └── page2.js
├── img
│   ├── favicon.png
│   ├── MoreiraDevelopment.svg
│   ├── SpaceOne.jpg
│   └── SpaceTwo.jpg
├── index.html
├── js
│   ├── js_index.js
│   └── js_page2.js
├── page2.html
├── php
│   ├── 404.php
│   ├── archive.php
│   ├── author.php
│   ├── category.php
│   ├── comments.php
│   ├── footer.php
│   ├── functions.php
│   ├── header.php
│   ├── index.php
│   ├── loop.php
│   ├── page.php
│   ├── pagination.php
│   ├── searchform.php
│   ├── search.php
│   ├── sidebar.php
│   ├── single.php
│   ├── tag.php
│   └── template-demo.php
├── screenshot.png
└── styles
    ├── buttons.scss
    ├── forms.scss
    ├── global-main.scss
    ├── icons.scss
    ├── print.scss
    ├── scaffolding.scss
    ├── typography.scss
    ├── utilities.scss
    ├── variables.scss
    └── wp_core.scss

```
It is very important to respect the folter structure  and maintain files in the right place

1. /app
... The /app folder holds the main JavaScript file for each of the templates or pages being builti.
... Each of the javascript files is responsible for importing any necessary
Styles and javascript pertinent to that page. Anything imported through here
will be passed through Webpack for processing and bundled.

2. /img
... Store all images for the templates here. Subfolders are fine - there is a
function inside ./app/index.js that crawls the folder and requires all images.
... favicon.png must be present since Webpack packages favicons through the
pipeline.

3. /js
... This is where you will store the JavaScript files you write for each of
these pages. Don't forget to import each file through the parent JavaScript file
contained in the /app folder.

4. /styles
... This folder contains all of the styles used to generate pages. You can add
new stylesheets if necessary, just make sure you add them to the load order in
the global-main.scss file.
... It is worth nothing that this project makes use of the
@moreira-development/sass-boilerplate library and therefore comes with a
plethora of useful classes already built in. [ SASS-BOILERPLATE DOCUMENTATION
](https://github.com/MoreiraDevelopment/sass-boilerplate).

5. /php
... This is where you will store and add any PHP files related to Wordpress Themes.
... Files inside of PHP folder will be copied over to the root of the /dist folder.

6. /themeinfo
... The purpose of this folder is to house the style.css file required by
wordpress to make themes work in the backend.
... Don't forget to change any pertinent information in the style.css prior to
shipping the finished product.

### Output File Strucutre
```bash
mdev-theme
├── 404.php
├── archive.php
├── author.php
├── category.php
├── comments.php
├── css
│   └── styles.css
├── footer.php
├── functions.php
├── header.php
├── icons
│   ├── android-chrome-144x144.png
│   ├── android-chrome-192x192.png
│   ├── android-chrome-256x256.png
│   ├── android-chrome-36x36.png
│   ├── android-chrome-384x384.png
│   ├── android-chrome-48x48.png
│   ├── android-chrome-512x512.png
│   ├── android-chrome-72x72.png
│   ├── android-chrome-96x96.png
│   ├── apple-touch-icon-114x114.png
│   ├── apple-touch-icon-120x120.png
│   ├── apple-touch-icon-144x144.png
│   ├── apple-touch-icon-152x152.png
│   ├── apple-touch-icon-167x167.png
│   ├── apple-touch-icon-180x180.png
│   ├── apple-touch-icon-57x57.png
│   ├── apple-touch-icon-60x60.png
│   ├── apple-touch-icon-72x72.png
│   ├── apple-touch-icon-76x76.png
│   ├── apple-touch-icon.png
│   ├── apple-touch-icon-precomposed.png
│   ├── apple-touch-startup-image-1182x2208.png
│   ├── apple-touch-startup-image-1242x2148.png
│   ├── apple-touch-startup-image-1496x2048.png
│   ├── apple-touch-startup-image-1536x2008.png
│   ├── apple-touch-startup-image-320x460.png
│   ├── apple-touch-startup-image-640x1096.png
│   ├── apple-touch-startup-image-640x920.png
│   ├── apple-touch-startup-image-748x1024.png
│   ├── apple-touch-startup-image-750x1294.png
│   ├── apple-touch-startup-image-768x1004.png
│   ├── favicon-16x16.png
│   ├── favicon-32x32.png
│   ├── favicon.ico
│   ├── firefox_app_128x128.png
│   ├── firefox_app_512x512.png
│   ├── firefox_app_60x60.png
│   ├── manifest.json
│   └── manifest.webapp
├── img
│   ├── favicon.png
│   ├── MoreiraDevelopment.svg
│   ├── SpaceOne.jpg
│   └── SpaceTwo.jpg
├── index.html
├── index.php
├── js
│   ├── bundle-index.js
│   └── bundle-page2.js
├── loop.php
├── page2.html
├── page.php
├── pagination.php
├── searchform.php
├── search.php
├── sidebar.php
├── single.php
├── style.css
├── tag.php
└── template-demo.php
```



## Webpack Notes
If you are new to Webpack it is probably worth taking a few hours to go read
some documentation or watch some tutorials on it. Basically Webpack is
responsible for taking all of our files and processing them to be ready for the
web.

Because of this it is important that you take note of a couple of configuration
items so you can add more pages when necessary.

1. Theme Name Configuration
... The theme name given to the theme output folder is setup through Webpack.
... At the very start of the file, after all the imports you will see a constant called THEME_NAME,
whatever you set this variable to is what the output folder will be called.

```javascript
// [ THEME NAME ] ---------------------/
// Determines the name of the output folder
// that webpack will create to adhere to
// wordpress documentation.
const THEME_NAME        = 'mdev-theme'
exports.THEME_NAME      = THEME_NAME
```

2. Entry Configuration
... The "entry" configuration in Webpack is responsible for telling webpack how
many files it needs to deal with and how they are to be split.
... For our purposes you must remember to add new entrys if you want new
templates to also be compiled.

```javascript
  // [ ENTRY ] -----------------------/
  // Entry indicates to webpack how many
  // webpages and JS files it needs to output.
  // You must add a new entry per page, each page
  // should have it's own app/[pagename].js
  // with it's own imports.
  entry: {
    index: 'src/app/index.js',
    page2: 'src/app/page2.js'
    newTemplate: 'src/app/newTemplate.js'
  },
```

3. Output
... All of the files imported or required through the entry file will be bundled
into a CSS bundle and a JS bundle. In our case we have it configured so CSS is
bundled into a single package and JS is split into individual files per page.
... This allows us some flexibility with Javascript and loading less assets per
page.

```javascript
  // [ OUTPUT ] ----------------------/
  // Configuration for how Webpack is going
  // to output the files for the server.
  // Each entry above will get it's own
  // named Bundle.
  output: {
    publicPath: '/',
    filename: 'js/bundle-[name].js',
    chunkFilename: 'js/chunk.[name].js',
    path: resolve(__dirname, 'dist'),
    pathinfo: ifNotProduction()
  },
```

4. Generate HTML Output
... Webpack was designed to run with Applications, but it can be taught to work
with HTML and static sites. It just takes some clever planning. In our case, we
are using different entry points per page.
... For each entry point you add, you must also add a call to generateHtml. This
is a generator that will tell Webpack to extrat the HTML using
html-webpack-plugin for each entry point corresponding to the appropriate
template.

```javascript
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
  generateHtml('newTemplate','newTemplate.html'),
```
