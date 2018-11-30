// Elements with the story attribute will be clickable and change the running story.
wickedElements.define('[story]', {
  onclick(event) {
    const storyName = this.el.getAttribute('story');
    runStoryByName(storyName);
  }
});


wickedElements.define('[choice-index]', {
  onclick(event) {
    const index = this.el.getAttribute('choice-index');
    // Remove all the choices
    document.querySelectorAll('.choice').forEach(elm => elm.remove());
    // continue the story
    window.story.ChooseChoiceIndex(index);
    continueStory();
  }
});
