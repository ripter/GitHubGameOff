/**
 * Process the tags in the the tags array updating the DOM/Game
 * @param {HTMLElement} elStory
 * @param  {Array} tags
 */
function processTags(elStory, tags) {
  tags
    .map(t => Array.from(t.match(/(\w+): ?(\w+)/))) // Converts "name: value" into [original, name, value]
    .map(t => t.slice(1)) // Remove the original string from the array.
    // Update the DOM based on the tags
    .forEach((tag) => {
      console.log('tag', tag);
      // switch on the tag name
      const name = tag[0].toLocaleUpperCase();
      const value = tag[1];

      switch (name) {
        case 'STORY':
          runStoryByName(value);
          break;
        default:
          // do nothing
      }
    });
}
