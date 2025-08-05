---
layout: default
title: Categorías
---
# Categorías
Aquí puedes ver todas las categorías.

<h1>Categorías</h1>
<ul>
  {% for category in site.categories %}
    <li>
      <a href="{{ site.baseurl }}/categories/{{ category[0] }}">
        {{ category[0] }} ({{ category[1].size }})
      </a>
    </li>
  {% endfor %}
</ul>
