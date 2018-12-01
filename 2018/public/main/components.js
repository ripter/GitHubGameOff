function componentChoice({index, text}) {
  return hyperHTML.wire()`<p class="choice">
    <a class="btn" choice-index=${index}>${text}</a>
  </p>`;
}

function componentKnot(knot) {
  const { paragraphs, tags } =  knot;
  const title = tags.title || '';
  const isMessageStyle = tags.style === 'message';
  const rootClass = [
     'container',
     'with-title',
  ].join(' ');
  let children;

  if (isMessageStyle) {
    children = componentMessage(paragraphs);
  }
  else {
    // Standard style
    children = paragraphs.map(componentParagraph);
  }

  return hyperHTML.wire(knot, ':container')`
  <section class=${rootClass}>
    <h2 class="title">${title}</h2>
    ${children}
  </section>`;
}

function componentMessage(paragraphs) {
  // Combine the message paragraphs together so they look like one.
  const messages = collapseMessages(paragraphs);
  return hyperHTML.wire()`
  <div class="messages">
    ${messages.map(componentMessageItem)}
  </div>`;
}

function componentMessageItem(message) {
  const { text, tags } = message;
  const side = tags.from;

  return hyperHTML.wire(message, ':message')`
  <div class=${`message --${side}`}>
    <div class=${`balloon from-${side}`}>
      ${text.map(t => `<p>${t}</p>`)}
    </div>
  </div>`;
}

function componentParagraph({ text }) {
  return hyperHTML.wire()`<p>${{html: text}}</p>`;
}


function collapseMessages(rawBlocks) {
  const MSG = {
    text: [],
    tags: {},
  };
  const messages = []

  // Starting block
  messages.push(JSON.parse(JSON.stringify(MSG)));
  rawBlocks.forEach(({tags, text}) => {
    let current = messages[messages.length-1];

    // Switch blocks when we get the message tag
    if (tags.style === 'message') {
      current = JSON.parse(JSON.stringify(MSG));
      messages.push(current);
    }

    // Update the block
    current.text.push(text);
    current.tags = Object.assign({}, current.tags, tags);
  });

  return messages;
}
