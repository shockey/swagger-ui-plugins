Swagger UI 'Disable Oas Spec Link' Plugin
==================================================================

Prevent the display of the OpenAPI specification URL link.

Original post: https://github.com/swagger-api/swagger-ui/issues/4171

## Usage

### Require

First, install the module with npm:
```
$ npm install --save swagger-ui-plugin-disable-oas-spec-link
```

Next, require it in your client-side application:

```js
const DisableOasSpecLinkPlugin = require('swagger-ui-plugin-disable-oas-spec-link');

SwaggerUI({
  // your options here...
  plugins: [
    DisableOasSpecLinkPlugin
  ]
})
```

### `<script>`

```html
<!-- Load Swagger UI -->
<script src="https://unpkg.com/swagger-ui-dist/swagger-ui-bundle.js"> </script> 
<!-- Load the DisableOasSpecLink Plugin -->
<script src="https://unpkg.com/swagger-ui-plugin-disable-oas-spec-link"> </script>

<script>
window.onload = function() {
  SwaggerUI({
    // your options here...
    plugins: [
      DisableOasSpecLinkPlugin
    ]
  })
}
</script>
```
