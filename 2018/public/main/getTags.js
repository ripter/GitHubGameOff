/**
 * Convert the Tags array into an object of key:value pairs
 * @param  {Array} tags - array of "key: value;" strings
 * @return {Object}
 */
function getTags(tags) {
  const regNameValue = /(\w+): ?([^;]*)/; // Converts "name: value;" into [original, name, value]
  return tags.reduce((acc, tag) => {
    const match = regNameValue.exec(tag);
    acc[match[1]] = match[2];
    return acc;
  }, {})
}
