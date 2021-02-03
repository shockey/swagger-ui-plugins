// From: https://raw.githubusercontent.com/chilts/umd-template/master/template.js
; ((f) => {
  // module name and requires
  var name = 'DisableOasSpecLinkPlugin';
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
      // see https://github.com/facebook/react/issues/3037
      g = this;
    }
    g[name] = f.apply(null, requires.map(function (r) { return g[r]; }));
  }

})(() => {
  // Module source
  return (system) => {
    return {
			wrapComponents: {
				InfoUrl: () => () => null,
				InfoBasePath: () => () => null, // this hides the `Base Url` part too, if you want that
			}
    }
  };
});
