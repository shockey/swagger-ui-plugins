Swagger UI 'Hierarchical Tags' Plugin
==================================================================
This plugin produces a side-bar layout with endpoints grouped into a hierarhical list based on tags with (optional) special delimiter characters to denote hierarchy.

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

### `<script>`

```html
<!-- Load Swagger UI -->
<script src="https://unpkg.com/swagger-ui-dist/swagger-ui-bundle.js"> </script> 
<!-- Load the HierarchicalTags Plugin -->
<script src="https://unpkg.com/swagger-ui-plugin-hierarchical-tags"> </script>

<script>
window.onload = function() {
  SwaggerUI({
  // your options here...
  plugins: [
    HierarchicalTagsPlugin
  ]
})
}
</script>
```
