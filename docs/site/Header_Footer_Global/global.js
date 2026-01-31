document.addEventListener("DOMContentLoaded", () => {
  const includes = document.querySelectorAll("[data-include]");

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

        const height = doc?.body?.scrollHeight;
        if (height) {
          iframe.style.height = `${height}px`;
        }
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
