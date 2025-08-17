---
layout: reader
title: "Ririsa - Capítulo 2"
capitulo: 2
es_ultimo: true
manga_slug: ririsa
permalink: /ririsa/cap2/
images_json: /assets/mangas/ririsa/cap2/images.json
return_to: /ririsa/
---

<h1>{{ page.title }}</h1>
<div id="reader"></div>

<style>
  #reader img { width:100%; max-width:100%; height:auto; display:block; margin:0 auto 10px; }
  @media (min-width:1024px){
    body,html{ margin:0; padding:0; background:#000; }
    #reader{ max-width:100vw; }
    #reader img{ width:100vw; max-width:100vw; }
  }
  .error{ max-width:800px; margin:16px auto; padding:10px 12px; background:#2b1320; border:1px solid #4e1e36; color:#f0a3b8; border-radius:8px; }
  .back{ display:block; text-align:center; margin:30px auto; padding:10px 20px; background:#333; color:#fff; text-decoration:none; border-radius:5px; max-width:300px; }
  .back:hover{ background:#555; }
</style>

<script>
(async function(){
  const BASE = '{{ site.baseurl }}';
  const jsonPath = BASE + '{{ page.images_json }}'; // ya empieza con "/", no se pega
  const reader = document.getElementById('reader');

  try {
    const res = await fetch(jsonPath, { cache: 'no-cache' });
    if(!res.ok) throw new Error('HTTP '+res.status);
    const data = await res.json();

    // Normaliza: acepta arreglo de strings (URLs) o {pages:[{url|id,name}]}
    const pages = Array.isArray(data) ? data.map(u => ({ url:u })) :
                   (Array.isArray(data.pages) ? data.pages : []);

    if (!pages.length) throw new Error('JSON vacío o formato no soportado');

    // Orden robusto: busca número en name o en URL, sin exigir extensión al final
    pages.sort((a,b)=>{
      const A = (a.name || a.url || '').match(/(\d+)/);
      const B = (b.name || b.url || '').match(/(\d+)/);
      const nA = A ? parseInt(A[1],10) : 999999;
      const nB = B ? parseInt(B[1],10) : 999999;
      return nA - nB;
    });

    // Render
    const frag = document.createDocumentFragment();
    pages.forEach((p, idx) => {
      const img = document.createElement('img');

      // Si la URL es absoluta (http/https), NO le pegamos BASE
      if (/^https?:\/\//i.test(p.url || '')) {
        img.src = p.url.replace('export=download', 'export=view');
      } else if (p.id) {
        // Soporte por id (thumb + fallback)
        img.src = `https://drive.google.com/thumbnail?id=${encodeURIComponent(p.id)}&sz=w1600`;
        img.addEventListener('error', () => { img.src = `https://drive.google.com/uc?export=view&id=${encodeURIComponent(p.id)}`; }, { once:true });
      } else if (p.url) {
        // Ruta relativa dentro del sitio
        img.src = (p.url.startsWith('/')) ? (BASE + p.url) : (BASE + '/' + p.url);
      } else {
        return; // nada que mostrar
      }

      img.loading = 'lazy';
      img.decoding = 'async';
      frag.appendChild(img);
    });

    reader.textContent = '';
    reader.appendChild(frag);

  } catch (e) {
    reader.innerHTML = '<div class="error">No se pudieron cargar las imágenes. ' + e.message + '</div>';
  }

  // Botón regresar
  const back = document.createElement('a');
  back.className = 'back';
  back.href = BASE + '{{ page.return_to }}';
  back.textContent = '← Regresar al post';
  reader.appendChild(back);
})();
</script>
