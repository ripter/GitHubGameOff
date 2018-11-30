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


  function restart() {
    story.ResetState();

    setVisible(".header", true);

    continueStory(true);

    outerScrollContainer.scrollTo(0, 0);
  }

  // -----------------------------------
  // Various Helper functions
  // -----------------------------------




  // Remove all elements that match the given selector. Used for removing choices after
  // you've picked one, as well as for the CLEAR and RESTART tags.
  function removeAll(selector)
  {
    var allElements = elStory.querySelectorAll(selector);
    for(var i=0; i<allElements.length; i++) {
      var el = allElements[i];
      el.parentNode.removeChild(el);
    }
  }

  // Used for hiding and showing the header when you CLEAR or RESTART the story respectively.
  function setVisible(selector, visible)
  {
    var allElements = elStory.querySelectorAll(selector);
    for(var i=0; i<allElements.length; i++) {
      var el = allElements[i];
      if( !visible )
      el.classList.add("invisible");
      else
      el.classList.remove("invisible");
    }
  }

  // Helper for parsing out tags of the form:
  //  # PROPERTY: value
  // e.g. IMAGE: source path
  function splitPropertyTag(tag) {
    var propertySplitIdx = tag.indexOf(":");
    if( propertySplitIdx != null ) {
      var property = tag.substr(0, propertySplitIdx).trim();
      var val = tag.substr(propertySplitIdx+1).trim();
      return {
        property: property,
        val: val
      };
    }

    return null;
  }
}

// Main story processing function. Each time this is called it generates
// all the next content up as far as the next set of choices.
function continueStory(firstTime) {
  var paragraphIndex = 0;
  var delay = 0.0;
  let tags = {};

  // Don't over-scroll past new content
  var previousBottomEdge = firstTime ? 0 : contentBottomEdgeY();

  // if (story.currentTags.length > 0) {
  //   tags = getTags(story.currentTags);
  //   console.log('root tags', tags);
  // }


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

  // Create a root container for all the paragraphs
  if (knot.paragraphs.length > 0) {
    let title = knot.tags.title || '';
    const elContainer = componentSection(knot.paragraphs, title);
    elStory.appendChild(elContainer);
  }

  if (knot.style) {
    elContainer.classList.add(knot.style)
  }

  // Create the Choice buttons
  knot.choices.forEach(function(choice) {
    // Create paragraph with anchor element
    const elChoice = componentChoice(choice);
    elStory.appendChild(elChoice)

    // Fade choice in after a short delay
    showAfter(delay, elChoice);
    delay += 200.0;
  });

  // Extend height to fit
  // We do this manually so that removing elements and creating new ones doesn't
  // cause the height (and therefore scroll) to jump backwards temporarily.
  elStory.style.height = contentBottomEdgeY()+"px";

  if( !firstTime ) {
    scrollDown(previousBottomEdge);
  }
}

// Fades in an element after a specified delay
function showAfter(delay, el) {
  el.classList.add("hide");
  setTimeout(function() { el.classList.remove("hide") }, delay);
}
// The Y coordinate of the bottom end of all the story content, used
// for growing the container, and deciding how far to scroll.
function contentBottomEdgeY() {
  var bottomElement = elStory.lastElementChild;
  return bottomElement ? bottomElement.offsetTop + bottomElement.offsetHeight : 0;
}
// Scrolls the page down, but no further than the bottom edge of what you could
// see previously, so it doesn't go too far.
function scrollDown(previousBottomEdge) {
  // Line up top of screen with the bottom of where the previous content ended
  var target = previousBottomEdge;

  // Can't go further than the very bottom of the page
  var limit = outerScrollContainer.scrollHeight - outerScrollContainer.clientHeight;
  if( target > limit ) target = limit;

  var start = outerScrollContainer.scrollTop;

  var dist = target - start;
  var duration = 300 + 300*dist/100;
  var startTime = null;
  function step(time) {
    if( startTime == null ) startTime = time;
    var t = (time-startTime) / duration;
    var lerp = 3*t*t - 2*t*t*t; // ease in/out
    outerScrollContainer.scrollTo(0, (1.0-lerp)*start + lerp*target);
    if( t < 1 ) requestAnimationFrame(step);
  }
  requestAnimationFrame(step);
}
