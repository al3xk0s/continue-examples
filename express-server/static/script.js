const img = document.querySelector('.photo__image');

img?.addEventListener("click", (e) => {
    const name = 'src';
    const attributeValue = img.getAttribute(name);
    img.attributes.removeNamedItem(name);
    img.setAttribute(name, attributeValue);
})