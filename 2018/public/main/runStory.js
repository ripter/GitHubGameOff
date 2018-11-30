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

  if (story.currentTags.length > 0) {
    tags = getTags(story.currentTags);
    console.log('root tags', tags);
  }


  //
  // story uses the while(bool) {} style syntax which is not ideal for us.
  // So convert to an object.
  let knot = {
    paragraphs: [],
    tags: getTags(story.currentTags),
  };
  while(story.canContinue) {
    const paragraph = {
      text: story.Continue(),
      tags: getTags(story.currentTags),
    };
    knot.paragraphs.push(paragraph);
    knot.tags = Object.assign({}, knot.tags, paragraph.tags);
    // console.log('getTags', getTags(story.currentTags));
    // knot.paragraphs.push({
    //   text: story.Continue(),
    //   // tags: getTags(story.currentTags),
    // });
    // const paragraphText = story.Continue();
    // knot.paragraphs.push({text: paragraphText});
    // if (story.currentTags.length > 0) {
    //   // knot.tags = Object.assign(knot.tags, getTags(story.currentTags));
    //   // console.log('paragraph tags', getTags(story.currentTags));
    // }
  }
  console.log('knot', knot);

  //
  // use the knot object to generate the HTML and perform actions.
  // Check for the story tag, it changes the active story.
  if (knot.tags.story) {
    runStoryByName(knot.tags.story);
    return;
  }

  // Create a root container for all the paragraphs
  let title = knot.tags.title || '';
  const elContainer = componentSection(knot.paragraphs, title);
  elStory.appendChild(elContainer);

  // Generate story text - loop through available content
  /*
  while(story.canContinue) {
    const paragraphText = story.Continue();
    let tags = {};

    // Tags are used to update the DOM.
    if (story.currentTags.length > 0) {
      tags = getTags(story.currentTags);
    }

    // Story tag loads a new Ink story file.
    if (tags.story) {
      if (tags.status === 'disabled') {
        console.log(`Story (${tags.story}) is currently disabled`);
        break;
      }
      runStoryByName(tags.story);
      return;
    }

    let paragraphElement;
    if (false && tags.template) {
      console.log('template', tags);
      switch (tags.template) {
        case 'section':
          elParagraph = componentSection();
          paragraphElement = elParagraph;
          break;
        default:
          console.log('unknown template');
      }
    }
    else {
      // Create paragraph element (initially hidden)
      paragraphElement = document.createElement('p');
      paragraphElement.innerHTML = paragraphText;
    }
    // elStory.appendChild(paragraphElement);
    elContainer.appendChild(paragraphElement);


    // // Speaker tags add extra styles
    // if (tags.speaker) {
    //   [
    //     `speaker-${tags.speaker}`,
    //     'balloon',
    //     'container',
    //     'with-title',
    //   ].forEach(name => paragraphElement.classList.add(name));
    // }

    // Fade in paragraph after a short delay
    // showAfter(delay, paragraphElement);
    delay += 200.0;
  }
  */

  // Create HTML choices from ink choices
  story.currentChoices.forEach(function(choice) {
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
