import { HierarchicalOperations } from "./HierarchicalOperations";
import { HierarchicalOperationTag } from "./HierarchicalOperationTag";

// From: https://raw.githubusercontent.com/chilts/umd-template/master/template.js
; ((f) => {
  // module name and requires
  var name = 'HierarchicalTagsPlugin';
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
  return (/*system*/) => {
    return {
      components: {
        // Provide our classes raw for others
        HierarchicalOperations,
        HierarchicalOperationTag,
        // Override operations so it uses our component instead of the original
        operations: HierarchicalOperations,
      },
    }
  };
});



