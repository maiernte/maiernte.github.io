{% if theme.mathjax.enable %}
  {% if not theme.mathjax.per_page or (page.total or page.mathjax) %}
    <script type="text/x-mathjax-config">
      MathJax.Hub.Config({
        tex2jax: {
          inlineMath: [ ['$','$'], ["\\(","\\)"]  ],
          processEscapes: true,
          skipTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
        }
      });
    </script>

    <script type="text/x-mathjax-config">
      MathJax.Hub.Queue(function() {
        var all = MathJax.Hub.getAllJax(), i;
        for (i=0; i < all.length; i += 1) {
          all[i].SourceElement().parentNode.className += ' has-jax';
        }
      });
    </script>

    <script type="text/javascript" src="{{ theme.mathjax.cdn }}"></script>
    <script src="https://raw.githack.com/maiernte/img/master/libs/bundle.js?华鹤=1&字体=5&水土=1&短名=1&katex=0"></script>
  {% endif %}
{% endif %}
