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
assets/      Local workstation product preview images
vendor/      Locally vendored Font Awesome Free CSS and solid icon assets
Dockerfile.Cognit  Production container definition for the static site
compose.yaml       Docker Compose service definition
Makefile           Docker build and container lifecycle commands
```

There is no application runtime to start and no dependency installation is required.
Font Awesome Free 6.7.2 is included locally under `vendor/fontawesome/` for offline static
serving. Its license is included at `vendor/fontawesome/LICENSE.txt`.

## Customer Deployment Model

The public Cognit website is hosted as a normal static site. Customer AI systems follow a
different model: Cognit does not currently buy, own, or operate a shared hardware fleet for
customers.

The current pre-built workstation engagement flow is:

1. Assess the customer's work, data, privacy requirements, and operating environment.
2. Select a pre-built, out-of-the-box workstation from the catalog.
3. Cognit purchases the selected system on the customer's behalf.
4. Cognit prepares the workstation, initializes local AI, and configures the agreed network and business integration.
5. Cognit ships the prepared workstation to the customer's campus and completes or supports on-site deployment.
6. Cognit provides training and operational documentation.
7. The customer owns the hardware, access management, updates, backups, maintenance, and day-to-day operation.

Ongoing support or remote assistance can be defined separately for an engagement. It is not
assumed that Cognit hosts the customer's workloads or retains remote administrative access.
Custom workstation builds are not offered yet and are marked as coming soon on the site.

## Workstation Catalog Assets

Product preview images are stored locally under `assets/workstations/` so the static site does
not depend on retailer image URLs at runtime. All current workstation product and image sources
are Newegg listings; availability and exact configurations should be confirmed before purchase.

- Lenovo ThinkStation P2 Gen 2: [Newegg listing](https://www.newegg.com/p/1VK-0003-1SRG2)
- ADAMANT 24-Core AI Learning Workstation: [Newegg listing](https://www.newegg.com/p/3D5-002T-00RS4)
- NVIDIA DGX SPARK: [Newegg listing](https://www.newegg.com/pny-technologies-inc-dgx-personal-ai-computer-20-core-arm-10-cortex-x925-10-cortex-a725-arm-nvdgxspark-pb/p/N82E16856987001)

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

The current static page does not parse shell configuration automatically. The Docker image serves
the files as-is and does not substitute configuration values into the HTML. Copy the relevant
values manually into `index.html` or into the hosting provider's project settings. In particular:

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

## Run With Docker

The site has no dependency installation, build step, or application server. `Dockerfile.Cognit`
uses nginx to serve the static files on port 80. The Makefile wraps Docker Compose for the common
image and container operations:

```bash
make
```

Running `make` without a target displays the available commands. `make help` displays the same
help text. To build and start the site:

```bash
make build
make run
```

`make run` builds the image if needed, starts the container in the background, and publishes the
container's port 80 at `http://localhost:8080` by default. The image includes an HTTP health check
against the site root.

Follow the container logs:

```bash
make logs
```

Stop the container and remove the Cognit image, containers, volumes, and Compose orphans created
for this project:

```bash
make clean
```

The cleanup target is scoped to this Compose project and does not run a system-wide Docker prune.
To use a different host port, set `COGNIT_HOST_PORT` when starting the service:

```bash
COGNIT_HOST_PORT=8081 make run
```

The equivalent direct Compose command is:

```bash
docker compose up -d --build
```

`cognit.env` is intentionally not copied into the image or loaded by the Dockerfile, Compose file,
or Makefile. The current container runs nginx only, and neither nginx nor the browser-side
JavaScript consumes the `COGNIT_*` values. Passing `--env-file ./cognit.env` to Docker is therefore
harmless but has no effect on the rendered page. Use an env file only after adding a server-side
process or a startup templating step that explicitly reads the variables. Keep deployment values
outside the image and never commit secrets.

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

The hosting provider should handle CDN delivery and HTTPS certificate renewal. Docker is an
optional self-hosting path; if it is used publicly, put the container behind a reverse proxy or
load balancer that handles HTTPS. A backend or database is not needed for this version of Cognit.

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
