document.addEventListener("DOMContentLoaded", () => {
  const includes = document.querySelectorAll("[data-include]");

  const syncIframeHeight = (iframe) => {
    if (!iframe) {
      return;
    }
    const doc = iframe.contentDocument;
    const height = doc?.body?.scrollHeight;
    if (height) {
      iframe.style.height = `${height}px`;
    }
  };

  const setupHeaderMenu = (doc) => {
    if (!doc || doc.documentElement?.dataset.headerMenuBound === "true") {
      return;
    }
    doc.documentElement.dataset.headerMenuBound = "true";

    const setMenuState = (header, open) => {
      if (!header) {
        return;
      }
      header.classList.toggle("menu-open", open);
      const toggle = header.querySelector(".nav-toggle");
      if (toggle) {
        toggle.setAttribute("aria-expanded", open ? "true" : "false");
      }
    };

    const syncFrameForDoc = () => {
      const iframe = doc.defaultView?.frameElement;
      if (iframe) {
        syncIframeHeight(iframe);
      }
    };

    doc.addEventListener("click", (event) => {
      const toggle = event.target.closest(".nav-toggle");
      if (toggle) {
        const header = toggle.closest(".site-header");
        const isOpen = toggle.getAttribute("aria-expanded") === "true";
        setMenuState(header, !isOpen);
        syncFrameForDoc();
        return;
      }

      const openHeader = doc.querySelector(".site-header.menu-open");
      if (!openHeader) {
        return;
      }

      if (event.target.closest(".nav a")) {
        setMenuState(openHeader, false);
        syncFrameForDoc();
        return;
      }

      if (!event.target.closest(".site-header")) {
        setMenuState(openHeader, false);
        syncFrameForDoc();
      }
    });

    doc.addEventListener("keydown", (event) => {
      if (event.key !== "Escape") {
        return;
      }
      const openHeader = doc.querySelector(".site-header.menu-open");
      if (openHeader) {
        setMenuState(openHeader, false);
        syncFrameForDoc();
      }
    });

    if (doc.defaultView?.frameElement) {
      doc.defaultView.addEventListener("resize", () => syncFrameForDoc());
    }
  };

  setupHeaderMenu(document);

  const replaceWithIframe = (node, path) => {
    const iframe = document.createElement("iframe");
    iframe.className = "global-include-frame";
    if (node.id) {
      iframe.dataset.includeRole = node.id.replace("global-", "");
    }
    iframe.src = path;

    iframe.addEventListener("load", () => {
      try {
        const doc = iframe.contentDocument;
        if (doc && !doc.querySelector("link[data-global-css]")) {
          const link = doc.createElement("link");
          link.rel = "stylesheet";
          link.href = new URL("global.css", new URL(path, window.location.href)).href;
          link.dataset.globalCss = "true";
          doc.head.appendChild(link);
        }

        syncIframeHeight(iframe);
        setupHeaderMenu(doc);

        iframe.contentWindow?.addEventListener("resize", () => syncIframeHeight(iframe));
      } catch (error) {
        console.error(error);
      }
    });

    node.replaceWith(iframe);
  };

  includes.forEach((node) => {
    const path = node.getAttribute("data-include");
    if (!path) {
      return;
    }

    fetch(path)
      .then((response) => {
        if (!response.ok) {
          throw new Error(`Failed to load ${path}`);
        }
        return response.text();
      })
      .then((html) => {
        node.outerHTML = html;
      })
      .catch((error) => {
        console.error(error);
        replaceWithIframe(node, path);
      });
  });
});
