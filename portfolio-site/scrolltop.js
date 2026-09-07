(function () {
  const scrollToTopBtn = document.createElement('button');
  scrollToTopBtn.id = 'scrollToTop';
  scrollToTopBtn.type = 'button';
  scrollToTopBtn.title = 'Revenir au haut de la page';
  scrollToTopBtn.setAttribute('aria-label', 'Revenir au haut de la page');
  scrollToTopBtn.textContent = '\u2191';
  document.body.appendChild(scrollToTopBtn);

  function updateVisibility() {
    scrollToTopBtn.classList.toggle('show', window.scrollY > 300);
  }

  window.addEventListener('scroll', updateVisibility, { passive: true });
  scrollToTopBtn.addEventListener('click', function () {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  });

  updateVisibility();
})();
