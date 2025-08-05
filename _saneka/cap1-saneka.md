---
title: "Saneka - Capítulo 1"
layout: default
permalink: /cap1-saneka/
images_json: /assets/mangas/saneka/cap1/images.json
---

<h1>{{ page.title }}</h1>
<div id="reader"></div>

<script>
fetch('{{ site.baseurl }}{{ page.images_json }}')
  .then(response => response.json())
  .then(images => {
    const reader = document.getElementById('reader');
    images.forEach(img => {
      const image = document.createElement('img');
      image.src = '{{ site.baseurl }}' + img;
      image.loading = 'lazy';
      image.style.width = '100%';
      image.style.marginBottom = '10px';
      reader.appendChild(image);
    });
  })
  .catch(err => {
    document.getElementById('reader').innerHTML = "<p>No se pudieron cargar las imágenes.</p>";
  });
</script>
