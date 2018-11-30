function componentChoice({index, text}) {
  return hyperHTML.wire()`<p class="choice">
    <a class="btn" choice-index=${index}>${text}</a>
  </p>`;
}
