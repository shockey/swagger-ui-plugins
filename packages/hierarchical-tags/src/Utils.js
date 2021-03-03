import { sanitizeUrl as braintreeSanitizeUrl } from "@braintree/sanitize-url"
import cssEscape from "css.escape"

/**
 * This entire file is composed of pieces copied directly from swagger-ui core utils
 */

export function isAbsoluteUrl(url) {
  return url.match(/^(?:[a-z]+:)?\/\//i) // Matches http://, HTTP://, https://, ftp://, //example.com,
}

export function addProtocol(url) {
  if (!url.match(/^\/\//i)) return url // Checks if protocol is missing e.g. //example.com

  return `${window.location.protocol}${url}`
}

export function buildBaseUrl(selectedServer, specUrl) {
  if (!selectedServer) return specUrl
  if (isAbsoluteUrl(selectedServer)) return addProtocol(selectedServer)

  return new URL(selectedServer, specUrl).href    
}

export function buildUrl(url, specUrl, { selectedServer="" } = {}) {
  if (!url) return
  if (isAbsoluteUrl(url)) return url

  const baseUrl = buildBaseUrl(selectedServer, specUrl)
  if (!isAbsoluteUrl(baseUrl)) {
    return new URL(url, window.location.href).href
  }
  return new URL(url, baseUrl).href
}

export function isFunc(thing) {
  return typeof(thing) === "function"
}

// suitable for use in URL fragments
export const createDeepLinkPath = (str) => typeof str == "string" || str instanceof String ? str.trim().replace(/\s/g, "%20") : ""
// suitable for use in CSS classes and ids
export const escapeDeepLinkPath = (str) => cssEscape( createDeepLinkPath(str).replace(/%20/g, "_") )

export function sanitizeUrl(url) {
  if(typeof url !== "string" || url === "") {
    return ""
  }

  return braintreeSanitizeUrl(url)
}

/**
 * These constants are from the original Operations.jsx file
 */

export const SWAGGER2_OPERATION_METHODS = [
  "get", "put", "post", "delete", "options", "head", "patch"
]

export const OAS3_OPERATION_METHODS = SWAGGER2_OPERATION_METHODS.concat(["trace"])
