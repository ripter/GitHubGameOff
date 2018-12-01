function componentChoice({index, text}) {
  return hyperHTML.wire()`<p class="choice">
    <a class="btn" choice-index=${index}>${text}</a>
  </p>`;
}

function componentSection(paragraphs, title = '') {
  return hyperHTML.wire()`<section class="container with-title">
    <h2 class="title">${title}</h2>
    ${paragraphs.map(({text, tags}) => {
      return `<p class=${tags.style|false}>${text}</p>`;
    })}
  </section>`;
}
