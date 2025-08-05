---
layout: reader
title: "Ririsa - Capítulo 2"
capitulo: 2
manga_slug: ririsa
permalink: /ririsa/cap2/
images_json: /assets/mangas/ririsa/cap2/images.json
return_to: /ririsa/
---

<h1>{{ page.title }}</h1>
<div id="reader"></div>

<style>
  /* Estilo base: imágenes ocupan el 100% del contenedor */
  #reader img {
    width: 100%;
    max-width: 100%;
    height: auto;
    display: block;
    margin: 0 auto 10px auto;
  }

  /* En pantallas grandes (mayores a 1024px) → imágenes fullscreen */
  @media (min-width: 1024px) {
    body, html {
      margin: 0;
      padding: 0;
      background: #000; /* opcional: fondo negro tipo lector */
    }
    #reader {
      max-width: 100vw;
    }
    #reader img {
      width: 100vw;
      max-width: 100vw;
    }
  }
</style>


<script>
fetch('{{ site.baseurl }}{{ page.images_json }}')
  .then(response => response.json())
  .then(images => {
    const reader = document.getElementById('reader');

    // Ordenar numéricamente por el número en el nombre del archivo
    images.sort((a, b) => {
      const numA = parseInt(a.match(/(\d+)\.(jpg|png|webp)$/)[1]);
      const numB = parseInt(b.match(/(\d+)\.(jpg|png|webp)$/)[1]);
      return numA - numB;
    });

    // Agregar imágenes ya ordenadas
    images.forEach(img => {
      const image = document.createElement('img');
      image.src = '{{ site.baseurl }}' + img;
      image.loading = 'lazy';
      image.style.width = '100%';
      image.style.marginBottom = '10px';
      reader.appendChild(image);
    });

    // Crear botón de regresar
    const backButton = document.createElement('a');
    backButton.href = '{{ site.baseurl }}{{ page.return_to }}';
    backButton.textContent = '← Regresar al post';
    backButton.style.display = 'block';
    backButton.style.textAlign = 'center';
    backButton.style.margin = '30px auto';
    backButton.style.padding = '10px 20px';
    backButton.style.background = '#333';
    backButton.style.color = '#fff';
    backButton.style.textDecoration = 'none';
    backButton.style.borderRadius = '5px';
    backButton.onmouseover = () => backButton.style.background = '#555';
    backButton.onmouseout = () => backButton.style.background = '#333';
    reader.appendChild(backButton);
  })
  .catch(err => {
    document.getElementById('reader').innerHTML = "<p>No se pudieron cargar las imágenes.</p>";
  });
</script>
