function componentChoice({index, text}) {
  return hyperHTML.wire()`<p class="choice">
    <a class="btn" choice-index=${index}>${text}</a>
  </p>`;
}

function componentSection(paragraphs, title = '') {
  return hyperHTML.wire()`<section class="container with-title">
    <h2 class="title">${title}</h2>
    ${paragraphs.map(({text, tags}) => {
      return `<p>${text}</p>`;
    })}
  </section>`;
}


function componentKnot(knot) {
  const { paragraphs, tags } =  knot;
  const title = tags.title || '';
  const isMessageStyle = tags.style === 'message';
  const rootClass = [
     'container',
     'with-title',
     isMessageStyle ? 'messages' : '',
  ].join(' ');

  return hyperHTML.wire(knot, ':container')`
  <section class=${rootClass}>
    <h2 class="title">${title}</h2>
    ${paragraphs.map(componentParagraph)}
  </section>`;
}

function componentParagraph(paragraph) {
  const { tags } = paragraph;
  const isMessageStyle = tags.style === 'message';
  const rootClass = [
   isMessageStyle ? 'message' : '',
  ].join(' ');
  return hyperHTML.wire(paragraph)`
  <p class=${rootClass}>
    ${paragraph.text}
  </p>`
}
