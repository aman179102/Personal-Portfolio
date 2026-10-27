# Aman Kumar — Portfolio

Static portfolio and engineering case studies for Aman Kumar, a full-stack software engineer building web products, developer tools, and distributed systems.

Live: [amanfolioo.netlify.app](https://amanfolioo.netlify.app/)

## Stack

- Semantic HTML5
- Hand-written CSS
- Vanilla JavaScript
- JSON-LD structured data
- Netlify hosting

No framework, no build step, and no npm dependency is required to run the site.

## Pages

- `/` — homepage and selected work
- `/work/` — filterable project index
- `/work/podvoice.html` — AI podcast studio case study
- `/work/distributed-file-storage.html` — distributed storage case study
- `/work/codepad.html` — browser code editor case study
- `/work/analytics-pipeline.html` — real-time analytics case study
- `/work/trust-aware.html` — human-in-the-loop AI case study
- `/work/type-env.html` — typed environment validation case study
- `/about.html` — background, experience, skills, and principles
- `/resume.html` — HTML résumé with embedded PDF
- `/resume.pdf` — downloadable PDF

## Local development

From the repository root:

```bash
python3 -m http.server 8000
```

Then open `http://localhost:8000`.

## Structure

```text
.
├── index.html
├── about.html
├── resume.html
├── 404.html
├── work/
├── assets/
│   ├── css/styles.css
│   ├── js/main.js
│   └── img/
├── sitemap.xml
├── robots.txt
├── site.webmanifest
├── _headers
└── _redirects
```

## SEO and structured data

Every page includes:

- A unique title, description, and canonical URL
- Open Graph and Twitter Card metadata
- A shared `Person` entity with `sameAs` links to GitHub, LinkedIn, X, Instagram, Dev.to, and LeetCode
- `WebSite` and page-level JSON-LD
- Breadcrumb structured data on case studies
- `SoftwareSourceCode` structured data on project pages

The homepage is a `ProfilePage`; project pages are `WebPage` documents with an associated `SoftwareSourceCode` entity.

## Editing

Project cards and case-study content are plain HTML. Shared styling lives in `assets/css/styles.css`; theme, menu, scroll reveal, copy-email, and filter behavior live in `assets/js/main.js`.

## Deployment

The site is deployed with Netlify from the `main` branch. Push changes to `main` to publish. Netlify reads `_headers` for security and cache headers and `_redirects` for URL redirects.
