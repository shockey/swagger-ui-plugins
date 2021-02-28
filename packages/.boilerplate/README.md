Swagger UI '{proper-name}' Plugin
==================================================================



## Usage

### Require

First, install the module with npm:
```
$ npm install --save swagger-ui-plugin-{name-kebab-case}
```

Next, require it in your client-side application:

```js
const {name-pascal-case}Plugin = require('swagger-ui-plugin-{name-kebab-case}');

SwaggerUI({
  // your options here...
  plugins: [
    {name-pascal-case}Plugin
  ]
})
```

### `<script>`

```html
<!-- Load Swagger UI and related -->
<link rel="stylesheet" type="text/css" href="https://unpkg.com/swagger-ui-dist/swagger-ui.css"></link>
<script src="https://unpkg.com/react@17/umd/react.production.min.js"></script>
<script src="https://unpkg.com/swagger-ui-dist/swagger-ui-bundle.js"> </script> 

<!-- Load the {name-pascal-case} Plugin -->
<script src="https://unpkg.com/swagger-ui-plugin-{name-kebab-case}"> </script>

<script>
window.onload = function() {
  SwaggerUIBundle({
    url: "https://petstore.swagger.io/v2/swagger.json",
    dom_id: "#swagger-ui",

    // your options here...

    plugins: [
      {name-pascal-case}Plugin
    ],
  });
}
</script>
```

