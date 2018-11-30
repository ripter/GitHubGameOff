function componentChoice({index, text}) {
  return hyperHTML.wire()`<p class="choice">
    <a class="btn" choice-index=${index}>${text}</a>
  </p>`;
}

function componentSection({title}) {
  return hyperHTML.wire()`<section class="container with-title">
    <h2 class="title">${title}</h2>
    <div>
    <p>Content Goes here</p>
    </div>
  </section>`;
}
