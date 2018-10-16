# `DisableTryItOutWithoutServersPlugin`

By default, if you don't provide any remote server information in your OpenAPI definiton, Swagger UI will direct requests to the host the definition was loaded from:

> If the servers property is not provided, or is an empty array, the default value would be a Server Object with a url value of /.
> 
> https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.0.md#openapi-object

This plugin changes Swagger UI's behavior so that an empty or missing global `servers` field in an OpenAPI 3.0 document disables Try-It-Out completely.

If Swagger UI has a non-OpenAPI 3 definition loaded, this plugin will not affect Try-It-Out visibility or functionality.

## Usage

### Require

First, install the module with npm:
```
$ npm install --save swagger-ui-plugin-disable-try-it-out-without-servers
```

Next, require it in your client-side application:

```js
const DisableTryItOutWithoutServersPlugin = require('swagger-ui-plugin-disable-try-it-out-without-servers');

SwaggerUI({
  // your options here...
  plugins: [
    DisableTryItOutWithoutServersPlugin
  ]
})
```

### `<script>`

```html
<!-- Load Swagger UI -->
<script src="https://unpkg.com/swagger-ui-dist/swagger-ui-bundle.js"> </script> 
<!-- Load the DisableTryItOutWithoutServersPlugin -->
<script src="https://unpkg.com/swagger-ui-plugin-disable-try-it-out-without-servers/build/index.js"> </script>

<script>
window.onload = function() {
  SwaggerUI({
  // your options here...
  plugins: [
    DisableTryItOutWithoutServersPlugin
  ]
})
}
</script>
```

# TODO

- Handle non-global `servers` data
- Implement similar logic for Swagger 2.0 definitions
- Write Jsest unit tests + Cypress integration tests
