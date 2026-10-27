(function () {
  "use strict";

  var root = document.documentElement;
  var header = document.querySelector(".site-header");
  var progress = document.querySelector(".scroll-progress__bar");
  var menuToggle = document.querySelector(".menu-toggle");
  var mobileMenu = document.querySelector(".mobile-menu");
  var themeButtons = document.querySelectorAll("[data-theme-toggle]");
  var revealItems = document.querySelectorAll(".reveal");

  function setTheme(theme) {
    root.dataset.theme = theme;
    try {
      localStorage.setItem("theme", theme);
    } catch (error) {}
    themeButtons.forEach(function (button) {
      var next = theme === "dark" ? "light" : "dark";
      button.setAttribute("aria-label", "Switch to " + next + " theme");
      button.setAttribute("title", "Switch to " + next + " theme");
    });
  }

  function storedTheme() {
    try {
      return localStorage.getItem("theme");
    } catch (error) {
      return null;
    }
  }

  setTheme(storedTheme() || (window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"));

  themeButtons.forEach(function (button) {
    button.addEventListener("click", function () {
      setTheme(root.dataset.theme === "dark" ? "light" : "dark");
    });
  });

  function onScroll() {
    var top = window.scrollY || window.pageYOffset;
    if (header) {
      header.classList.toggle("is-scrolled", top > 8);
    }
    if (progress) {
      var height = document.documentElement.scrollHeight - window.innerHeight;
      progress.style.width = (height > 0 ? Math.min((top / height) * 100, 100) : 0) + "%";
    }
  }

  window.addEventListener("scroll", onScroll, { passive: true });
  onScroll();

  function closeMenu() {
    if (!mobileMenu || !menuToggle) return;
    mobileMenu.classList.remove("is-open");
    menuToggle.setAttribute("aria-expanded", "false");
  }

  if (menuToggle && mobileMenu) {
    menuToggle.addEventListener("click", function () {
      var isOpen = mobileMenu.classList.toggle("is-open");
      menuToggle.setAttribute("aria-expanded", isOpen ? "true" : "false");
    });

    mobileMenu.querySelectorAll("a").forEach(function (link) {
      link.addEventListener("click", closeMenu);
    });

    document.addEventListener("keydown", function (event) {
      if (event.key === "Escape") closeMenu();
    });

    window.addEventListener("resize", function () {
      if (window.innerWidth > 860) closeMenu();
    });
  }

  if ("IntersectionObserver" in window && revealItems.length) {
    var observer = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-visible");
            observer.unobserve(entry.target);
          }
        });
      },
      { rootMargin: "0px 0px -8% 0px", threshold: 0.08 }
    );

    revealItems.forEach(function (item) {
      observer.observe(item);
    });
  } else {
    revealItems.forEach(function (item) {
      item.classList.add("is-visible");
    });
  }

  document.querySelectorAll("[data-current-year]").forEach(function (node) {
    node.textContent = String(new Date().getFullYear());
  });

  document.querySelectorAll("[data-copy-email]").forEach(function (button) {
    button.addEventListener("click", function () {
      var email = button.getAttribute("data-copy-email");
      var original = button.getAttribute("data-label") || button.textContent;
      if (!email) return;
      var done = function () {
        button.textContent = "Copied";
        window.setTimeout(function () {
          button.textContent = original;
        }, 1600);
      };
      if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(email).then(done).catch(function () {});
      } else {
        var area = document.createElement("textarea");
        area.value = email;
        area.setAttribute("readonly", "");
        area.style.position = "fixed";
        area.style.opacity = "0";
        document.body.appendChild(area);
        area.select();
        try {
          document.execCommand("copy");
          done();
        } catch (error) {}
        document.body.removeChild(area);
      }
    });
  });

  var filterButtons = document.querySelectorAll("[data-filter]");
  var projectCards = document.querySelectorAll("[data-category]");

  if (filterButtons.length && projectCards.length) {
    filterButtons.forEach(function (button) {
      button.addEventListener("click", function () {
        var filter = button.getAttribute("data-filter");
        filterButtons.forEach(function (item) {
          var active = item === button;
          item.classList.toggle("is-active", active);
          item.setAttribute("aria-pressed", active ? "true" : "false");
        });
        projectCards.forEach(function (card) {
          var matches = filter === "all" || card.getAttribute("data-category").indexOf(filter) !== -1;
          card.classList.toggle("is-hidden", !matches);
        });
      });
    });
  }
})();
