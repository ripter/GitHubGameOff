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

  // Global tags - those at the top of the ink file
  // We support:
  //  # theme: dark
  //  # author: Your Name
  var globalTags = story.globalTags;
  if( globalTags ) {
    for(var i=0; i<story.globalTags.length; i++) {
      var globalTag = story.globalTags[i];
      var splitTag = splitPropertyTag(globalTag);

      // THEME: dark
      if( splitTag && splitTag.property == "theme" ) {
        document.body.classList.add(splitTag.val);
      }

      // author: Your Name
      else if( splitTag && splitTag.property == "author" ) {
        var byline = document.querySelector('.byline');
        byline.innerHTML = "by "+splitTag.val;
      }
    }
  }

  // Kick off the start of the story!
  continueStory(true);

  // Main story processing function. Each time this is called it generates
  // all the next content up as far as the next set of choices.
  function continueStory(firstTime) {

    var paragraphIndex = 0;
    var delay = 0.0;

    // Don't over-scroll past new content
    var previousBottomEdge = firstTime ? 0 : contentBottomEdgeY();

    // Generate story text - loop through available content
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
        break;
      }

      // Create paragraph element (initially hidden)
      var paragraphElement = document.createElement('p');
      paragraphElement.innerHTML = paragraphText;
      elStory.appendChild(paragraphElement);

      // Speaker tags add extra styles
      if (tags.speaker) {
        paragraphElement.classList.add(`speaker-${tags.speaker}`);
      }
      // Add any custom classes derived from ink tags
      // for(var i=0; i<customClasses.length; i++)
      // paragraphElement.classList.add(customClasses[i]);

      // Fade in paragraph after a short delay
      showAfter(delay, paragraphElement);
      delay += 200.0;
    }

    // Create HTML choices from ink choices
    story.currentChoices.forEach(function(choice) {

      // Create paragraph with anchor element
      var choiceParagraphElement = document.createElement('p');
      choiceParagraphElement.classList.add("choice");
      choiceParagraphElement.innerHTML = `<a href='#'>${choice.text}</a>`
      elStory.appendChild(choiceParagraphElement);

      // Fade choice in after a short delay
      showAfter(delay, choiceParagraphElement);
      delay += 200.0;

      // Click on choice
      var choiceAnchorEl = choiceParagraphElement.querySelectorAll("a")[0];
      choiceAnchorEl.addEventListener("click", function(event) {

        // Don't follow <a> link
        event.preventDefault();

        // Remove all existing choices
        removeAll("p.choice");

        // Tell the story where to go next
        story.ChooseChoiceIndex(choice.index);

        // Aaand loop
        continueStory();
      });
    });

    // Extend height to fit
    // We do this manually so that removing elements and creating new ones doesn't
    // cause the height (and therefore scroll) to jump backwards temporarily.
    elStory.style.height = contentBottomEdgeY()+"px";

    if( !firstTime )
    scrollDown(previousBottomEdge);
  }

  function restart() {
    story.ResetState();

    setVisible(".header", true);

    continueStory(true);

    outerScrollContainer.scrollTo(0, 0);
  }

  // -----------------------------------
  // Various Helper functions
  // -----------------------------------

  // Fades in an element after a specified delay
  function showAfter(delay, el) {
    el.classList.add("hide");
    setTimeout(function() { el.classList.remove("hide") }, delay);
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

  // The Y coordinate of the bottom end of all the story content, used
  // for growing the container, and deciding how far to scroll.
  function contentBottomEdgeY() {
    var bottomElement = elStory.lastElementChild;
    return bottomElement ? bottomElement.offsetTop + bottomElement.offsetHeight : 0;
  }

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
