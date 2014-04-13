//about menu
document.querySelector('#btn-about').addEventListener ('click', function () {
  document.querySelector('#about').className = 'current';
  document.querySelector('[data-position="current"]').className = 'left';
});
document.querySelector('#btn-about-back').addEventListener ('click', function () {
  document.querySelector('#about').className = 'right';
  document.querySelector('[data-position="current"]').className = 'current';
});
