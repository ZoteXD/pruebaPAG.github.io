# Bienvenido a mi Blog Moderno
Aquí verás las entradas más recientes.

<h1>Entradas recientes</h1>
<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a> - {{ post.date | date: "%d/%m/%Y" }}
    </li>
  {% endfor %}
</ul>
