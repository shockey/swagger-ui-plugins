Swagger UI 'Hide Empty Tags' Plugin
==================================================================

Taken from comment https://github.com/swagger-api/swagger-ui/issues/4157#issuecomment-363917366

## Usage

### Require

First, install the module with npm:
```
$ npm install --save swagger-ui-plugin-hide-empty-tags
```

Next, require it in your client-side application:

```js
const HideEmptyTagsPlugin = require('swagger-ui-plugin-hide-empty-tags');

SwaggerUI({
  // your options here...
  plugins: [
    HideEmptyTagsPlugin
  ]
})
```

### `<script>`

```html
<!-- Load Swagger UI -->
<script src="https://unpkg.com/swagger-ui-dist/swagger-ui-bundle.js"> </script> 
<!-- Load the HideEmptyTags Plugin -->
<script src="https://unpkg.com/swagger-ui-plugin-hide-empty-tags"> </script>

<script>
window.onload = function() {
  SwaggerUI({
  // your options here...
  plugins: [
    HideEmptyTagsPlugin
  ]
})
}
</script>
```

