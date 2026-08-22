#!/bin/sh
set -eu

json_escape() {
  printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

site_url=$(json_escape "${COGNIT_SITE_URL:-https://www.your-domain.example}")
contact_email=$(json_escape "${COGNIT_CONTACT_EMAIL:-consult@cognit.com}")
location=$(json_escape "${COGNIT_LOCATION:-[Your city / region]}")
legal_details=$(json_escape "${COGNIT_LEGAL_DETAILS:-[Replace with your legal or business details]}")
form_provider=$(json_escape "${COGNIT_FORM_PROVIDER:-formspree}")
form_endpoint=$(json_escape "${COGNIT_FORM_ENDPOINT:-https://formspree.io/f/REPLACE_WITH_FORM_ID}")
form_subject=$(json_escape "${COGNIT_FORM_SUBJECT:-New Cognit consultation inquiry}")
form_redirect_url=$(json_escape "${COGNIT_FORM_REDIRECT_URL:-}")

{
  printf '%s\n' 'window.COGNIT_CONFIG = Object.freeze({'
  printf '  siteUrl: "%s",\n' "$site_url"
  printf '  contactEmail: "%s",\n' "$contact_email"
  printf '  location: "%s",\n' "$location"
  printf '  legalDetails: "%s",\n' "$legal_details"
  printf '  formProvider: "%s",\n' "$form_provider"
  printf '  formEndpoint: "%s",\n' "$form_endpoint"
  printf '  formSubject: "%s",\n' "$form_subject"
  printf '  formRedirectUrl: "%s"\n' "$form_redirect_url"
  printf '%s\n' '});'
} > /usr/share/nginx/html/site-config.js
