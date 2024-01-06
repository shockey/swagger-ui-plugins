Swagger UI 'Hierarchical Tags' Plugin
==================================================================

This plugin produces a layout with endpoints grouped into a hierarhical list based on tags with (optional) special
delimiter characters to denote hierarchy. Delimiter characters are `|` and `:` by default, but may be configured using
the `hierarchicalTagSeparator` config option.

(ref discussions [here](https://github.com/swagger-api/swagger-ui/issues/5969) and [here](https://github.com/OAI/OpenAPI-Specification/issues/1367))


## Installation and Setup

The easiest way to use this plugin for front-end projects is to link to it from your html via unpkg.
Below is a full working html document that you can use as a starting point:

```html
<!doctype html>
<html>
  <head>
    <!-- Load Swagger UI -->
    <script src="https://unpkg.com/swagger-ui-dist/swagger-ui-bundle.js"></script> 

    <!-- Load the HierarchicalTags Plugin -->
    <script src="https://unpkg.com/swagger-ui-plugin-hierarchical-tags"></script>

    <!-- Load styles -->
    <link rel="stylesheet" type="text/css" href="https://unpkg.com/swagger-ui-dist/swagger-ui.css" />

    <script>
      window.onload = function() {
        SwaggerUIBundle({
          url: "https://unpkg.com/swagger-ui-plugin-hierarchical-tags/example/pet-store.json",
          dom_id: "#swagger",
          plugins: [
            HierarchicalTagsPlugin
          ],
          hierarchicalTagSeparator: /[:|]/
        })
      }
    </script>
  </head>
  <body>
    <div id="swagger"></div>
  </body>
</html> 
```

### Installing Locally Via NPM

#### Installation via https://npmjs.com

Install as you would any other package: `npm i --save swagger-ui-plugin-hierarchical-tags`

#### Installation via Github Packages

> **NOTE:** This was how I was serving the package before I decided that https://github.com/shockey/swagger-ui-plugins
> was unresponsive. You can still get it this way, but it's probably easier to just use unpkg or npmjs now. See above
> for those methods.

<details>
  <summary>Github Packages Instructions</summary>

You can install this package from my personal github repo. To do so, you should create a
package-local `.npmrc` file, if not already created, and add the following to it:

```
@kael-shipman:registry=https://npm.pkg.github.com/kael-shipman
```

Next, if you have not already set up your system to use npm packages from github, you'll have to set
up github authentication for npm:

1. Create a github personal access token for your account ([tutorial](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)).
   I believe the only scope you'll need for your token is `read:packages` (which is _underneath_
   `write:packages` - you don't have to check them both).
2. Add `//npm.pkg.github.com/:_authToken=YOUR-TOKEN` to your user-specific `.npmrc` file. (The one
   at `~/.npmrc`, NOT the one in your package repo. If `~/.npmrc` doesn't exist, then create it.)
   Make sure to put the value of your token in instead of the string `YOUR-TOKEN`.

Once you've done that, you should be able to install it as normal like so:

```
npm install --save @kael-shipman/swagger-ui-plugin-hierarchical-tags
```

</details>

#### Usage

To use a local install, require it in your client-side application and apply it to your swagger instance:

```js
const HierarchicalTagsPlugin = require('@kael-shipman/swagger-ui-plugin-hierarchical-tags');

SwaggerUI({
  // your options here...
  plugins: [
    HierarchicalTagsPlugin
  ],
  hierarchicalTagSeparator: /[:|]/
})
```


## Hierarchical Tags Plugin Options

* `hierarchicalTagSeparator` - (Optional, defaults to `/[|:]/`) The separator character(s) on which to split
  hierarchical tags. Can be any string or regexp.


## Development


### Live-Testing Development

1. Clone this repo, cd into `packages/hierarchical-tags` and `npm install`
2. Run `npm start` - this starts a simple development web server that serves the files under the `example` directory.

From here, you should be able to go to `http://localhost:8080` in your browser and see the sample Pet Store API with
hierarchical tags active. You can mess around with the `example/pet-store.json` and `example/index.html` files to try
different inputs.

When you change the source code, just run `npm run build` to rebuild the plugin file in the `example` folder and reload
the page.


### Publishing

(This is more of a note-to-self.)

To publish the github package, simply bump the version and run `npm publish`.

To publish to unpkg (via npmjs.com), just remove the `@kael-shipman` prefix from the package name
and then run `npm publish` again. You should revert this change when you've successfully published
the package to npm.
