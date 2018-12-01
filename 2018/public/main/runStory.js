const elStory = document.querySelector('#story');
const outerScrollContainer = document.querySelector('.outerContainer');

/**
 * Starts an Ink story by name
 * @param  {String} name
 */
function runStoryByName(name) {
  const storyJSON = window[`${name}Content`];

  if (!storyJSON) {
    throw new Error('Could not find story data');
  }

  // Clear the old story
  elStory.innerHTML = '';
  // Running The Story
  runStory(storyJSON);
}



/**
 * Runs the Ink Story loop.
 */
function runStory(storyJSON) {
  // Create ink story from the content using inkjs
  var story = new inkjs.Story(storyJSON);
  // Great for quick prototyping to have a refrence on the debugger
  window.story = story;
  // Kick off the start of the story!
  continueStory(true);
}

// Main story processing function. Each time this is called it generates
// all the next content up as far as the next set of choices.
function continueStory(firstTime) {
  let tags = {};

  //
  // story uses the while(bool) {} style syntax which is not ideal for us.
  // So convert to an object.
  let knot = {
    tags: getTags(story.currentTags),
    paragraphs: [],
  };
  while(story.canContinue) {
    const paragraph = {
      text: story.Continue(),
      tags: getTags(story.currentTags),
    };
    // Ignore blank paragraphs
    if (paragraph.text !== '') {
      knot.paragraphs.push(paragraph);
    }
    // Keep a list of all tags in this knot
    knot.tags = Object.assign({}, knot.tags, paragraph.tags);
  }
  knot.choices = story.currentChoices.map(({index, text}) => {
    return {index, text}; // Return only the bits we care about as a new refrence.
  });
  console.log('knot', knot);


  //
  // use the knot object to generate the HTML and perform actions.
  // Check for the story tag, it changes the active story.
  if (knot.tags.story) {
    runStoryByName(knot.tags.story);
    return;
  }

  //
  // Render, appending the new knots to the dom.
  // A knot is 0 or more paragraphs followed by 1 or more choices
  //

  // Create a root container for all the paragraphs
  if (knot.paragraphs.length > 0) {
    const elContainer = componentKnot(knot);
    elStory.appendChild(elContainer);
  }

  // Create the Choice buttons
  knot.choices.forEach(function(choice) {
    // Create paragraph with anchor element
    const elChoice = componentChoice(choice);
    elStory.appendChild(elChoice)
  });
}
