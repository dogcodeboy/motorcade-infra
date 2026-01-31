# CODE SNAPSHOT — SITE_06 — Services overlap + hero wave blend checkpoint

This file captures the HTML/CSS state as pasted in chat so we can recover if the editor drifts.

## index.html (snapshot)
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Home</title>
  <link rel="stylesheet" href="../Header_Footer_Global/global.css">
  <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<div id="global-header" data-include="../Header_Footer_Global/header.html"></div>

<main>

  <section class="hero" id="top">
    <div class="hero-media" aria-hidden="true">
      <picture>
        <source
          type="image/webp"
          srcset="
            assets/images/hero-wave-motorcade-trust-640.webp 640w,
            assets/images/hero-wave-motorcade-trust-768.webp 768w,
            assets/images/hero-wave-motorcade-trust-1024.webp 1024w,
            assets/images/hero-wave-motorcade-trust-1280.webp 1280w,
            assets/images/hero-wave-motorcade-trust-1536.webp 1536w,
            assets/images/hero-wave-motorcade-trust-1920.webp 1920w,
            assets/images/hero-wave-motorcade-trust-2560.webp 2560w
          "
          sizes="100vw"
        >
        <img src="assets/images/hero-wave-motorcade-trust-1536.webp" alt="">
      </picture>
    </div>
    <div class="hero-wave" aria-hidden="true"></div>

    <div class="hero-inner">
      <div class="hero-left">
        <h1>Professional Armed<br>Security &amp; Executive<br>Protection</h1>
        <p class="hero-sub">Licensed, Trusted, Discreet</p>
        <p class="hero-body">
          Your secure future starts here. Calm, professional protection—built around clear planning,
          experienced personnel, and discreet execution.
        </p>

        <div class="hero-actions">
          <a class="btn-primary" href="#contact">Schedule Appointment</a>
        </div>
      </div>

    </div>
  </section>

  <section class="services" id="services">
    <div class="section-inner">
      <h2 class="section-title">Experienced Protection Services</h2>
      <p class="section-lead">
        Motorcade Security Solutions offers a range of specialized protection services tailored to meet the unique
        needs of our clientele.
      </p>

      <div class="service-icon-grid">
        <article class="service-icon-card">
          <div class="icon-square">
            <img src="assets/icons/icon-armed.svg" alt="">
          </div>
          <h3>Armed Security</h3>
          <p>Uniformed officers protecting people, property, and sensitive locations.</p>
        </article>

        <article class="service-icon-card">
          <div class="icon-square">
            <img src="assets/icons/icon-briefcase.svg" alt="">
          </div>
          <h3>Executive Protection</h3>
          <p>Discreet, plain-clothes protection for executives, families, and travel.</p>
        </article>

        <article class="service-icon-card">
          <div class="icon-square">
            <img src="assets/icons/icon-route.svg" alt="">
          </div>
          <h3>Escort &amp; Convoy</h3>
          <p>Coordinated, secure movement for high-profile and high-value assets.</p>
        </article>
      </div>
    </div>
  </section>

  <section class="audience" id="audience">
    <div class="section-inner audience-inner">
      <div class="audience-left">
        <h2 class="section-subtitle">Who We Secure</h2>
        <p class="section-lead section-lead-left">
          We support organizations and individuals who require protection that is reliable, discreet, and accountable.
        </p>
        <div class="audience-grid">
          <div class="audience-item">
            <img class="audience-photo" src="assets/images/service_01_executive_protection.jpg" alt="">
            <span>Executives &amp; Leadership</span>
          </div>
          <div class="audience-item">
            <img class="audience-photo" src="assets/images/service_02_armed_security.jpg" alt="">
            <span>High Net Worth</span>
          </div>
          <div class="audience-item">
            <img class="audience-photo" src="assets/images/service_03_security_consulting.jpg" alt="">
            <span>Commercial Facilities</span>
          </div>
          <div class="audience-item">
            <img class="audience-photo" src="assets/images/process_01_request.jpg" alt="">
            <span>Special Events</span>
          </div>
        </div>
      </div>
      <div class="audience-right">
        <h2 class="section-subtitle accent">What Sets Us Apart</h2>
        <ul class="apart-list">
          <li>
            <span class="check-icon" aria-hidden="true"></span>
            <div>
              <h3>Highly Trained Armed Professionals</h3>
              <p>Certified personnel with extensive experience in executive protection and security operations.</p>
            </div>
          </li>
          <li>
            <span class="check-icon" aria-hidden="true"></span>
            <div>
              <h3>Proactive Risk Assessment</h3>
              <p>We evaluate threats early and establish protocols that prevent incidents before they arise.</p>
            </div>
          </li>
          <li>
            <span class="check-icon" aria-hidden="true"></span>
            <div>
              <h3>Technology Driven Operations</h3>
              <p>Modern tools and intelligence workflows support real-time coordination and response.</p>
            </div>
          </li>
          <li>
            <span class="check-icon" aria-hidden="true"></span>
            <div>
              <h3>Discretion &amp; Confidentiality</h3>
              <p>We operate with the privacy, professionalism, and restraint high-profile clients expect.</p>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </section>

</main>

<div id="global-footer" data-include="../Header_Footer_Global/footer.html"></div>

<script src="../Header_Footer_Global/global.js" defer></script>
</body>
</html>

styles.css (snapshot)

height:100%;
object-fit:contain;
object-fit:cover;
object-position:center bottom;
bottom: calc(-1 * var(--services-overlap));
height: calc(var(--services-overlap) + clamp(120px, 12vw, 180px));
height: calc(var(--services-overlap) + clamp(160px, 16vw, 240px));
background: url("../assets/images/wave.png") 58% 100% / 135% auto no-repeat;
opacity:0.82;
-webkit-mask-image: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.18) 28%, rgba(0,0,0,0.6) 58%, rgba(0,0,0,1) 100%);
mask-image: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.18) 28%, rgba(0,0,0,0.6) 58%, rgba(0,0,0,1) 100%);
opacity:0.78;
-webkit-mask-image: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.08) 36%, rgba(0,0,0,0.5) 65%, rgba(0,0,0,1) 100%);
mask-image: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.08) 36%, rgba(0,0,0,0.5) 65%, rgba(0,0,0,1) 100%);
z-index:2;
margin-top: calc(-1 * var(--services-overlap));
z-index:3;
}
.services .section-inner{
  padding-top: calc(var(--services-overlap) + 16px);
  padding-top: calc(var(--services-overlap) * 0.36);
  z-index: 6;

NOTE: This CSS snapshot reflects the conflicting/duplicated declarations pasted in chat, which is part of the problem we must clean up.


---

### 9) `docs/checkpoints/2026-01-31_SITE_06_SERVICES_OVERLAP_CHECKPOINT/CODEX_TASK_PROMPT.md`
```md
# CODEX TASK PROMPT — SITE_06 — Services overlap + hero wave blend checkpoint

Paste into Codex EXACTLY:

---
You are working in repo: `motorcade-infra`

Edit ONLY these files:
- `docs/site/site_06/index.html`
- `docs/site/site_06/css/styles.css`

Goal:
Make the SITE_06 “Services” section match the intended reference layout (hero + services overlap composition):

1) Hero photo must look full-bleed and not appear uniformly blue-washed.
2) Left gradient exists for text contrast only; it should fade out by ~70–80% width.
3) The bottom hero wave + soft white lift must blend hero into services as ONE composition.
4) The Services title (“Experienced Protection Services”), its lead text, and the 3 service cards must sit inside that overlap/lift region (lower third of hero), not in a detached flat band.
5) The “Who We Secure” (Audience) section must begin below the cards and must not be affected by hero/services overlays.

Rules:
- No stubs. No TODOs.
- Do not redesign typography/palette/copy.
- Remove duplicated/conflicting overlap CSS and choose ONE clean overlap model.
- Mobile must collapse naturally without collisions or huge gaps.

Deliverables:
- Provide exact diffs for both files.
- Explain the chosen layering model (positioning + z-index) in 5–10 bullets.
- Provide a verification checklist for desktop/tablet/mobile.

---
