// From: https://raw.githubusercontent.com/chilts/umd-template/master/template.js
; (function (f) {
  // module name and requires
  var name = 'DisableTryItOutWithoutServersPlugin';
  var requires = [];

  // CommonJS
  if (typeof exports === "object" && typeof module !== "undefined") {
    module.exports = f.apply(null, requires.map(function (r) { return require(r); }));

    // RequireJS
  } else if (typeof define === "function" && define.amd) {
    define(requires, f);

    // <script>
  } else {
    var g;
    if (typeof window !== "undefined") {
      g = window;
    } else if (typeof global !== "undefined") {
      g = global;
    } else if (typeof self !== "undefined") {
      g = self;
    } else {
      // works providing we're not in "use strict";
      // needed for Java 8 Nashorn
      // seee https://github.com/facebook/react/issues/3037
      g = this;
    }
    g[name] = f.apply(null, requires.map(function (r) { return g[r]; }));
  }

})(function () {
  // Module source
  return function(system) {
    return {
      statePlugins: {
        spec: {
          wrapSelectors: {
            allowTryItOutFor: (ori) => (...args) => {
              if (!system.specSelectors.isOAS3()) {
                // If we aren't looking at an OAS3 definition, allow it
                return ori(...args)
              }

              const spec = system.specSelectors.specJson()
              const servers = spec.get("servers")

              const serversExist = !!servers && servers.size > 0

              return serversExist ? ori(...args) : false
            }
          }
        }
      }
    }
  };
});
