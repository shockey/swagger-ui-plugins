Swagger UI 'Url Mutator' Plugin
==================================================================

Provides a Mechanism to override path, basePath and scheme for OpenAPI 2.x definitions

See original issue here: https://github.com/swagger-api/swagger-ui/issues/5981

## Usage

### Require

First, install the module with npm:
```
$ npm install --save swagger-ui-plugin-url-mutator
```

Next, require it in your client-side application:

```js
const UrlMutatorPlugin = require('swagger-ui-plugin-url-mutator');

SwaggerUI({
  // your options here...
  plugins: [
    UrlMutatorPlugin
  ],
  onComplete: () => {
    // this will set appropriate data when swagger-ui ready
    window.ui.setScheme('http');
    window.ui.setHost('www.google.com');
    window.ui.setBasePath('v3');
  }   
})
```

### `<script>`

```html
<!-- Load Swagger UI -->
<script src="https://unpkg.com/swagger-ui-dist/swagger-ui-bundle.js"> </script> 
<!-- Load the UrlMutator Plugin -->
<script src="https://unpkg.com/swagger-ui-plugin-url-mutator"> </script>

<script>
window.onload = function() {
  SwaggerUI({
    // your options here...
    plugins: [
      UrlMutatorPlugin
    ],
		onComplete: () => {
			// this will set appropriate data when swagger-ui ready
			window.ui.setScheme('http');
			window.ui.setHost('www.google.com');
			window.ui.setBasePath('v3');
		}   
  })
}
</script>
```
