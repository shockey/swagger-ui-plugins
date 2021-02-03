# ✨ Swagger UI Plugins

A multi-package repository of useful Swagger UI plugins maintained by [@shockey](https://github.com/shockey).

## 👉 Available Plugins

- [`disable-try-it-out-without-servers`](https://github.com/shockey/swagger-ui-plugins/tree/master/packages/disable-try-it-out-without-servers): enter documentation-only mode when OAS 3.0 `servers` is empty or missing
- [`hide-empty-tags`](https://github.com/shockey/swagger-ui-plugins/tree/master/packages/hide-empty-tags): hide empty tags
- [`url-mutator`](https://github.com/shockey/swagger-ui-plugins/tree/master/packages/url-mutator): mechanism to override path, basePath and scheme for OpenAPI 2.x definitions
- [`disable-oas-spec-link`](https://github.com/shockey/swagger-ui-plugins/tree/master/packages/disable-oas-spec-link): prevent the display of the OpenAPI specification URL link

## Contributing

Feel free to open issues and pull requests that fix bugs, add functionality, and introduce new plugins.

I will make releases of each plugin when/if your PR is accepted.

Please add yourself to the Contributors list below if you add a new plugin!

You can use the `npm run new-plugin` command to easily generate a new plugin skeleton from boilerplate. This should give you at least a reasonable head start on your plugin in a way that is generally compatible with the conventions in this library.

**One easy way to contribute is to copy over plugins found at https://github.com/swagger-api/swagger-ui/issues/5027#issuecomment-438745785.**

## Versioning

Each plugin uses [SemVer](http://semver.org/) for versioning. 

A plugin's version is unrelated to its Swagger UI compatibility: compatible versions are indicated by the plugin's Swagger UI `peerDependency`.

## Contributors

* **Kyle Shockey**: *Initial work; plugin maintenance*
* **Kael Shipman**: *Plugin boilerplate and script; limited ports of other people's plugins from around the web.*

## Built With

* [Lerna](https://lernajs.io) - a tool for managing JavaScript projects with multiple packages
* [Babel](https://babeljs.io) - a JavaScript compiler
* [Cypress](https://www.cypress.io) - fast, easy & reliable testing for anything that runs in a browser

## License

This project and all of its packages are licensed under the MIT License.
