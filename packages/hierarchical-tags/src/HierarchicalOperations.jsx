import React from "react"
import PropTypes from "prop-types"
import Im from "immutable"

/**
 * This is a direct copy of [this file](https://github.com/swagger-api/swagger-ui/blob/d3a65060628b79729445bc155f6d96a1ed1cd426/src/core/components/operations.jsx),
 * which was then modified to accommodate the necessary recursion for this plugin.
 */

export class HierarchicalOperations extends React.Component {

  static propTypes = {
    specSelectors: PropTypes.object.isRequired,
    specActions: PropTypes.object.isRequired,
    oas3Actions: PropTypes.object.isRequired,
    getComponent: PropTypes.func.isRequired,
    oas3Selectors: PropTypes.object.isRequired,
    layoutSelectors: PropTypes.object.isRequired,
    layoutActions: PropTypes.object.isRequired,
    authActions: PropTypes.object.isRequired,
    authSelectors: PropTypes.object.isRequired,
    getConfigs: PropTypes.func.isRequired,
    fn: PropTypes.object.isRequired
  };

  render() {
    let {
      specSelectors,
      getComponent,
      oas3Selectors,
      layoutSelectors,
      layoutActions,
      getConfigs,
      fn
    } = this.props

    // Get a flat map of tags to their set of operations
    let taggedOps = specSelectors.taggedOperations()

    // Get the component we need
    const HierarchicalOperationTag = getComponent("HierarchicalOperationTag")

    let {
      maxDisplayedTags,
      hierarchicalTagSeparator,
    } = getConfigs()

    if (!hierarchicalTagSeparator) {
      hierarchicalTagSeparator = /[:|]/
    }

    let filter = layoutSelectors.currentFilter()

    if (filter) {
      if (filter !== true && filter !== "true" && filter !== "false") {
        taggedOps = fn.opsFilter(taggedOps, filter)
      }
    }

    if (maxDisplayedTags && !isNaN(maxDisplayedTags) && maxDisplayedTags >= 0) {
      taggedOps = taggedOps.slice(0, maxDisplayedTags)
    }

    /**
     * Each taggedOperation is a tag with information and then some operations. All we need
     * to do is restructure this so that it reflects a hierarchical list instead of a flat
     * one.
     * 
     * Existing structure:
     *
     * type TagObj = unknown;
     * type TaggedOps = Map<TagName: string, TagObj>;
     *
     * Need to transform into:
     *
     * type HierarchicalOperationTag = {
     *   [TagName]: {
     *     data: TagObj & { canonicalTagName: string };
     *     childTags: Array<HierarchicalOperationTag>;
     *   }
     * }
     *
     */

    const tagHierarchy = {}
    taggedOps.map((data, tag) => {
      // Fill in canonicalTagName, if necessary
      if (!data.has("canonicalTagName")) {
        data = data.set("canonicalTagName", tag.replace(hierarchicalTagSeparator, "_"));
      }

      const parts = tag.split(hierarchicalTagSeparator);
      let current = tagHierarchy;
      for (let i = 0; i < parts.length; i++) {
        const part = parts[i];
        // if hierarchical structure not exists create it and add cursor for child tags
        if (current[part] === undefined) {
          current[part] = {
            data: null,
            childTags: {}
          }
        }

        // if point of insert reached add operations and tag information to structure
        if (i === parts.length - 1) {
          current[part].data = data;
        }
        current = current[part].childTags;
      }
    });

    return Object.keys(tagHierarchy).size === 0
      ? <h3> No operations defined in spec!</h3>
      :
      <HierarchicalOperationTag
        specSelectors={specSelectors}
        oas3Selectors={oas3Selectors}
        layoutSelectors={layoutSelectors}
        layoutActions={layoutActions}
        getConfigs={getConfigs}
        getComponent={getComponent}
        childTags={tagHierarchy}
        isRoot={true}
      />
  }
}

