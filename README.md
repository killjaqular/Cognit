# Cognit

Cognit is a static consultation website for an independent practice focused on customer-hosted
AI, private data, and useful information systems.

The site is intentionally small: it is plain HTML, CSS, and JavaScript with no frontend
framework, backend service, database, or build step. The contact form is ready for a hosted
form provider and currently contains a clearly marked endpoint placeholder.

## Site Content

The current page includes placeholders for:

- Cognit's positioning and introductory copy.
- Customer-owned, on-premises AI deployments and data boundaries.
- Consulting for public institutions, professional services, and growing teams.
- Business analysis, data engineering audits, and workshops.
- Custom software such as MCP servers, databases, data pipelines, and RAG systems.
- Three example case studies that should be replaced with real work.
- Contact details, location, legal details, and the eventual domain name.

The main files are:

```text
index.html   Page structure and content
styles.css   Responsive visual design
main.js      Mobile navigation and current-year enhancement
vendor/      Locally vendored Font Awesome Free CSS and solid icon assets
```

There is no application runtime to start and no dependency installation is required.
Font Awesome Free 6.7.2 is included locally under `vendor/fontawesome/` for offline static
serving. Its license is included at `vendor/fontawesome/LICENSE.txt`.

## Customer Deployment Model

The public Cognit website is hosted as a normal static site. Customer AI systems follow a
different model: Cognit does not currently buy, own, or operate a shared hardware fleet for
customers.

The intended engagement flow is:

1. Assess the customer's work, data, privacy requirements, and operating environment.
2. Specify the hardware, model, network, storage, and access requirements.
3. The customer purchases and owns the required hardware.
4. Cognit installs and configures the system on the customer's premises.
5. Cognit provides training and operational documentation.
6. The customer owns ongoing access management, updates, backups, maintenance, and day-to-day operation.

Ongoing support or remote assistance can be defined separately for an engagement. It is not
assumed that Cognit hosts the customer's workloads or retains remote administrative access.
This customer-owned deployment service is currently in development and will be offered in a
later phase rather than as a standard service today.

## Support Pricing

The website presents starting points for continued hands-on support:

| Tier | Monthly support | One-time write and deploy |
| --- | ---: | ---: |
| Foundation support | $1,000/month | From $1,600 |
| Working support | $1,250/month | From $2,000 |
| Embedded support | $1,500/month | From $2,400 |
| Special support | Contact for quote | Contact for quote |

Every tier requires a free one-hour consultation before work begins. The consultation is used
to learn the client's business, gauge the scope of work, understand the operating environment,
and identify the client's AI needs.

Monthly support is the lower-cost path for continued assistance. One-time write-and-deploy
services are priced approximately 60% higher. The customer still owns the hardware and ongoing
maintenance; a support plan provides optional continued Cognit assistance rather than transferring
that ownership.

## Configuration Reference

`cognit.conf.example` is the shared example configuration file. It contains default values
for the current static site as well as disabled placeholders for a possible future host,
backend, and inquiry database.

Create a local copy when working with real deployment values:

```bash
cp cognit.conf.example cognit.conf
```

The local `cognit.conf` file is ignored by Git. Do not put real passwords, API keys, or private
database connection strings in `cognit.conf.example` or commit them in `cognit.conf`.

The current static page does not parse shell configuration automatically. Until a build or
deployment layer is introduced, copy the relevant values manually into `index.html` or into
the hosting provider's project settings. In particular:

- `COGNIT_SITE_URL`, `COGNIT_PUBLIC_HOST`, and `COGNIT_CONTACT_EMAIL` correspond to visible site and contact placeholders.
- `COGNIT_FORM_ENDPOINT` is the hosted-form action that must replace the placeholder in `index.html`.
- `COGNIT_PUBLIC_SITE_HOSTING_PROVIDER` and `COGNIT_HOST_PUBLIC_IP` describe hosting for the public Cognit website only.
- `COGNIT_CUSTOMER_*` describes the customer-owned, on-premises deployment model, including hardware ownership, installation, training, and maintenance responsibility.
- `COGNIT_SUPPORT_*` describes the free consultation requirement, starting monthly support prices, one-time write-and-deploy prices, and support scope placeholders.
- `COGNIT_AI_*` and `COGNIT_DATA_*` describe the intended customer-hosting, data-residency, access, retention, and telemetry defaults for future implementations.
- `COGNIT_BACKEND_*` and `COGNIT_DATABASE_*` are future configuration values and remain disabled while the site is static.

The local-AI and on-premises settings are policy defaults, not a security guarantee. A real
engagement still needs an explicit review of infrastructure, network access, identity and
permissions, model behavior, logging, updates, retention, backups, physical security, and
applicable legal requirements.

## Hosted Form Setup

The contact form uses a regular HTML `POST` request. This keeps the site static while a
hosted provider receives and forwards submissions.

The form currently contains this placeholder action in `index.html`:

```html
https://formspree.io/f/REPLACE_WITH_FORM_ID
```

Before launch:

1. Create a form with a provider such as Formspree, Netlify Forms, Basin, or another service.
2. Replace `REPLACE_WITH_FORM_ID` with the endpoint supplied by that provider.
3. Confirm `consult@cognit.com` is the intended contact address.
4. Replace the visible form setup note with the provider's final instructions, if needed.
5. Configure spam protection and notification delivery with the provider.
6. Do not ask prospective customers to submit confidential, regulated, or proprietary information through this initial hosted form.
7. Add a privacy notice describing how inquiry data is handled.

Do not advertise the form as operational until the provider endpoint has been configured and
tested. No contact submissions are stored by this repository.

## Run Locally

Use any static file server. Python's standard library is enough:

```bash
python3 -m http.server 8000
```

Run that command from the repository root, then open:

```text
http://localhost:8000
```

Opening `index.html` directly may work for the page itself, but a local HTTP server gives a
closer match to how the site will be served publicly.

## Deploy Publicly

This site can be deployed to Cloudflare Pages, Netlify, Vercel, GitHub Pages, or another
static hosting provider.

The generic deployment settings are:

```text
Build command:       none
Publish directory:   repository root
```

The usual flow is:

1. Push the repository to a Git host.
2. Create a new static-site project with the hosting provider.
3. Connect the repository.
4. Set the publish directory to the repository root.
5. Deploy the site.
6. Add the purchased custom domain through the provider's domain settings.
7. Follow the provider's DNS instructions for the root domain and `www` host.
8. Confirm that HTTPS is active.

The hosting provider should handle CDN delivery and HTTPS certificate renewal. A VPS,
Docker Compose stack, reverse proxy, and Go server are not needed for this version of Cognit.

## Replace Before Launch

Search the repository for bracketed placeholders and replace them with real information:

- `[Public information system]`
- `[Knowledge workflow]`
- `[Data foundation]`
- `[Your city / region]`
- `[Replace with your legal or business details]`
- `REPLACE_WITH_FORM_ID`
- `your-domain.example`

The example case studies are deliberately not presented as real client work. Replace them
with actual projects, outcomes, images, or remove the section until the material is ready.

## Future Scope

A custom backend can be added later if Cognit needs customer-controlled inquiry storage, CRM
integration, private project areas, customer-hosted model inference, custom AI workflows, or
other dynamic features. Those needs do not have to be decided in order to launch this
consultation site.
