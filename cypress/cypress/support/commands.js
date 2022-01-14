// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add('login', (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite('visit', (originalFn, url, options) => { ... })
Cypress.Commands.add('uploadFile', { prevSubject: true }, (subject, fixturePath, mimeType) => {
  cy.fixture(fixturePath, 'base64').then(content => {
    Cypress.Blob.base64StringToBlob(content, mimeType).then((blob) => {
      const testfile = new File([blob], fixturePath, { type: mimeType });
      const dataTransfer = new DataTransfer();
      const fileInput = subject[0];

      dataTransfer.items.add(testfile);
      fileInput.files = dataTransfer.files;

      cy.wrap(subject).trigger('change', { force: true });
    });
  });
})

