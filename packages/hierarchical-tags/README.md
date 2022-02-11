Swagger UI 'Hierarchical Tags' Plugin
==================================================================

This plugin produces a layout with endpoints grouped into a hierarhical list based on tags with
(optional) special delimiter characters to denote hierarchy. Delimiter characters are `|` and `:`.

## Usage

### Require

First, install the module with npm:
```
$ npm install --save swagger-ui-plugin-hierarchical-tags
```

Next, require it in your client-side application:

```js
const HierarchicalTagsPlugin = require('swagger-ui-plugin-hierarchical-tags');

SwaggerUI({
  // your options here...
  plugins: [
    HierarchicalTagsPlugin
  ]
})
```

### Direct linking using unpkg and `<script>` tags

You can also quickly and easily direct-link the file using unpkg.com. Below is a full working
html document that you can use as a starting point:

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
          ]
        })
      }
    </script>
  </head>
  <body>
    <div id="swagger"></div>
  </body>
</html> 
```

