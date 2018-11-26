/**
 * Process the tags in the the tags array updating the DOM/Game
 * @param {HTMLElement} elStory
 * @param  {Array} tags
 */
function processTags(elStory, tags) {
  const regNameValue = /(\w+): ?(\w+)/; // Converts "name: value" into [original, name, value]
  tags
    .map(t => Array.from(t.match(regNameValue)))
    .map(t => t.slice(1)) // Remove the original string from the array.
    // Update the DOM based on the tags
    .forEach((tag) => {
      // switch on the tag name
      const name = tag[0].toLocaleUpperCase();
      const value = tag[1];

      switch (name) {
        case 'STORY':
          runStoryByName(value);
          break;
        case 'RENDER':
          console.log('render tag found');
          break;
        default:
          // do nothing
          console.log('Unknown tags', name, value);
      }
    });
}

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
