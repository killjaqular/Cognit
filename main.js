const config = window.COGNIT_CONFIG ?? {};

const getConfigValue = (key, fallback = "") => {
  const value = config[key];
  return typeof value === "string" && value.trim() ? value.trim() : fallback;
};

const siteUrl = getConfigValue("siteUrl");
const contactEmail = getConfigValue("contactEmail", "consult@cognit.com");
const contactLocation = getConfigValue("location", "[Your city / region]");
const legalDetails = getConfigValue("legalDetails", "[Replace with your legal or business details]");

document.querySelectorAll("[data-contact-email]").forEach((element) => {
  element.textContent = contactEmail;
  element.setAttribute("href", `mailto:${contactEmail}`);
});

document.querySelectorAll("[data-contact-location]").forEach((element) => {
  element.textContent = contactLocation;
});

document.querySelectorAll("[data-contact-legal]").forEach((element) => {
  element.textContent = legalDetails;
});

if (siteUrl) {
  document.querySelector("link[rel=\"canonical\"]")?.setAttribute("href", siteUrl);
  document.querySelector("meta[property=\"og:url\"]")?.setAttribute("content", siteUrl);
}

const contactForm = document.querySelector("#contact-form");

if (contactForm) {
  const formEndpoint = getConfigValue(
    "formEndpoint",
    contactForm.getAttribute("action") || ""
  );
  const formProvider = getConfigValue("formProvider", "hosted form provider");
  const formSubject = getConfigValue("formSubject", "New Cognit consultation inquiry");
  const formRedirectUrl = getConfigValue("formRedirectUrl");
  const formNote = contactForm.querySelector("[data-form-note]");
  const subjectInput = contactForm.querySelector("[data-form-subject]");

  contactForm.setAttribute("action", formEndpoint);

  if (subjectInput) {
    subjectInput.setAttribute("value", formSubject);
  }

  if (formRedirectUrl) {
    const redirectInput = document.createElement("input");
    redirectInput.type = "hidden";
    redirectInput.name = "_next";
    redirectInput.value = formRedirectUrl;
    contactForm.append(redirectInput);
  }

  if (formNote && !formEndpoint.includes("REPLACE_WITH_FORM_ID")) {
    formNote.textContent = `Form handled by ${formProvider}. Do not include confidential, regulated, or proprietary information in this initial inquiry.`;
  }
}

const menuButton = document.querySelector(".menu-toggle");
const primaryNav = document.querySelector("#primary-nav");
const yearElement = document.querySelector("#current-year");

if (yearElement) {
  yearElement.textContent = new Date().getFullYear();
}

if (menuButton && primaryNav) {
  const closeMenu = () => {
    menuButton.setAttribute("aria-expanded", "false");
    primaryNav.classList.remove("is-open");
  };

  menuButton.addEventListener("click", () => {
    const isOpen = menuButton.getAttribute("aria-expanded") === "true";
    menuButton.setAttribute("aria-expanded", String(!isOpen));
    primaryNav.classList.toggle("is-open", !isOpen);
  });

  primaryNav.addEventListener("click", (event) => {
    if (event.target.closest("a")) {
      closeMenu();
    }
  });

  window.addEventListener("resize", () => {
    if (window.innerWidth > 720) {
      closeMenu();
    }
  });
}
